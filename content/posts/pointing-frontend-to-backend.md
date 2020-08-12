+++
title = "Where's your backend, kiddo?"
date = 2020-07-29T15:25:53+02:00
description = "Telling frontend where the backend is... with style!"
draft = false
categories = [""]
tags = []
+++

## Abstract

You've got your backend, a marvelous piece of code sitting comfortably in a container. And there it is - a beautiful frontend. The drop-in shadow on the buttons just makes you want to lick them. Of course it's containerized as well. And the problem arises: how can the frontend know where the backend is? The only problem with static frontends in that regard is that they are... well... static. Seams trivial but this is a surprisingly annoying one.

## A nope

In theory you could build a version of the app for every environment. In fact I know some people who do it that way and are quite fond of this way of doing business. In my case that simply won't do - I believe the information about the app environment should be passed through environment and just because it's frontend does not warrant an exception. They're already being considered "special" in the programming hood. 

Aside from my faith this would create a need for the CI to know about every app instance. While it's possible - it can quickly get nasty, even in a [zoo software](https://blog.ploeh.dk/2012/12/18/RangersandZookeepers/) environment, when an enterprise firewall enters the stage. Or you have many environments - for example one per client - and the business is going great.

## URL magic

One could deceive such a scheme where the frontend depends upon the API being at `$CURRENT_URL/api`. That's also a bad idea as it makes local debugging / error reproduction quite funny, provided a masochistic definition of funny. And a lack of sense of humour.

And speaking from experience - this approach seamed reasonable until the team I'd worked on was 8+ hours into trying to debug an issue involving a development version of the frontend and few other services. At that moment I've formed a strong opinion about how much clusterfucked that was. Pun intended.

## "runtime config"

Not one of my brightest moments, but I had this idea: what if frontend requested a `config.json` from `$CURRENT_URL/config.json`? The file would then contain the backend URL and some 3rd party services keys (now I know that stuff usually should go through the API anyway and that case was **not** an exception). Hell, we could even create the file via a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/), how hip of us!

In retrospection that sucked. The keys were up for grabs for a malicious actor. And I literally mean that **any** script kiddie capable of writing a `for` loop in Python 2.7 could do us considerable harm by exploiting those credentials that were a hotkey away. The solution also required an (surprise, surprise!) additional request before the content could be rendered, something very frowned upon in the frontend craft. On top of that we had trouble integrating the whole thing into React-Redux lifecycle management - not to say that's inherently cumbersome - simply it caused us a few *jajebieświnie*s. That's a Polish saying for when you are reconsidering your career choice as a programmer.

Yet with all it disadvantages it was both a superior way of configuring the frontend than none as well as a better love story than twilight.

## `do_shit.sed`

After that I've entertained a thought of postponing the final step of "building" until the container is actually ran. Though an amiable mind could say it's in the likes of [partial evaluation](https://en.wikipedia.org/wiki/Partial_evaluation) it's only as sophisticated as an `sed` script gets. Have the backend URL hardcoded to some #wellknown value and replace it a runtime - with the contents of an environment variable.

I never actually came around to implement this - but something rubs me the wrong way about processing all the `.js` files at runtime inside a Docker container.

## State of the art

Devops is about applying glue, so let's combine almost all of the ideas above.  Therefore let's just assume that api is at `/api` in production and can be set via `REACT_APP_BACKEND_URL` for development. If you're using [axios](https://github.com/axios/axios) as your HTTP library of choice then the code would look something like:

```js
function makeApiClient()
{
    const baseURL = 
        process.env.NODE_ENV === "development"
        ? process.env.REACT_APP_BACKEND_URL
        : "/api"
    ;

    return axios.create({
      baseURL,
      // timeouts, retries, etc.
    });
}
```

And the URL can be easily set in the following manner:
```sh
REACT_APP_BACKEND_URL=https://jsonplaceholder.typicode.com npm start
```

So far so good (except for the `REACT_APP_` prefix, but [don't hate the players - hate the game](https://create-react-app.dev/docs/adding-custom-environment-variables/)) , however it looks like we've [already been there](#url-magic). 

Since every problem in computer science can be solved by another layer of indirection[^1] let's have the frontend nginx server redirect the request to wherever the backend actually is. This possibly adds a tiny little bit of latency, but hey, hardware is cheap! So we need a way to parametrize the server configuration with an environment variable... and it magically turns out the official nginx Docker image has a [built-in template utility](https://github.com/docker-library/docs/blob/master/nginx/content.md#using-environment-variables-in-image-configuration-new-in-119) :D

So that this:
```docker
FROM nginx:beloved-tag
COPY ./dist/* /usr/share/nginx/html/
```

Becomes:

```docker
FROM nginx:beloved-tag
COPY ./templates/* /etc/nginx/templates/
COPY ./dist/* /usr/share/nginx/html/
```

If you're one of the mupptes that complains about image size and layer count - zip it![^2]. The actual configuration:
```nginx
#./templates/default.conf.template
server {
    listen       80;
    listen  [::]:80;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    location /api {
        rewrite \/api\/?(.*) /$1 break;
        proxy_pass ${BACKEND_URL};
    }
}
```

And finally you can set the backend URL (Nomad example):

```hcl
env {
  BACKEND_URL = "https://api.example.com"
}
```

## Epilogue

The whole piece doesn't yet touch on the issue if `service.example.com` is better than `example.com/service`. Semantically you could argue whenever you should address an infrastructure by services or by hosts (with me being on the service side, especially now with the cloud, kubernetes omnipresence and actual metal often being an afterthought) - but that's not the point. From my humble experience I conclude that if you have to run a more or less unknown app - just let it have it's own subdomain. It's less hassle that way. Some apps (like [the lounge](https://github.com/thelounge/thelounge)) can handle being hosted on a subpath quite gracefully, but why take that risk?

And as always - if you have better approach to the subject feel free to reach out to me and I'll gladly expand my understanding, enhance this post and give you a proper shout-out.

## Footnotes

[^1]: Except the problem of too many levels of indirection
[^2]: Again, pun intended
