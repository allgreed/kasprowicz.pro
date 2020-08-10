+++
title = "Where's your backend, kiddo?"
date = 2020-07-29T15:25:53+02:00
description = "Telling frontend where the backend is... with style!"
draft = true
categories = [""]
tags = []
+++

## Abstract

You've got your backend, a marvelous peace of code sitting comfortably in a container. And there is a piece of a beautiful frontend. The drop-in shadow on the buttons just makes you want to lick them. Of course it's containerized as well. And the the problem arises: how can the frontend know where the backend is? The only problem with static frotnends in that regards is that they are... well.. static. Seams trivial but this is a supprisingly annoying one.

## A nope

In theory you could build a version of the app for every environment. In fact I know some people who do it that way and are quite fond of this way of doing business. In my case that simply won't do - I believe the information about the app environment should be passed through environment and just because it's frontend does not warrant an exception. They're already being considered "special" in the programming hood. 

Aside from my faith this would create a need for the CI to know about every app instance. While it's possible - it can quickly get nasty, even in a [zoo software](https://blog.ploeh.dk/2012/12/18/RangersandZookeepers/) environment, when an enterprise firewall enters the stage. Or you have many environemnts - for example one per client and the business is going great.

## URL magic

One could deceive such a scheme where the frotend depdens upon the API being at `$CURRENT_URL/api`. That's also a bad idea as it makes local debugging / error reproduction quite funny, provided a masochistic definition of funny. And a lack of sense of humour.

And speaking from experiance - this appraoch seamed reasonable until the team I'd worked on was 8+ hours into trying to debug an issue involving a development version of the frontend and few other services. At that moment I've formed a strong opinion about how much clusterfucked that was. Pun inteded.

## "runtime config"

Not one of my brightest moments, but I had this idea: what if frontend requested a `config.json` from `$CURRENT_URL/config.json`. The file would then contain the backend URL and some 3rd party services keys (now I know that stuff usually should go through the API anyway and that case was **not** an exception). Hell, we could even create the file via a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/), how hip of us!

In retrospection that sucked. The keys were up for grabs for a malicious actor. And I literally mean that **any** script kiddie capable of writing a `for` loop in Python 2.7 could do us considerable harm by exploiting those credentials that were a hotkey away. The solution also required an (suprise, suprise!) additional request before the content could be rendered, something very frowned upon in the frontend craft. On top of that we had trouble integrating the whole thing into React-Redux lifecycle management - not to say that's inherently cumbersome - simply it caused us a few *jajebieświnie*s. That's a Polish saying for when you are reconsidering your career choice as a programmer.

Yet with all it disadvantages it was both a supperior way of configuring the frontend than none as well as a better love story than twilight.

## `do_shit.sed`

After that I've entertained a thought of postponing the final step of "building" until the container is actually ran. Though an amiable mind could say it's in the likes of [partial evalutaion](https://en.wikipedia.org/wiki/Partial_evaluation) it's only as sophisticated as an `sed` script gets. Have the backend URL hardcoded to some #wellknown value and replace it a runtime - with the contents of an environment variable.

I never actually came around to implement this - but something rubs me the wrong way about processing all the `.js` files at runtime inside a Docker container.

## state of the art

- since every problem in computer science can be solved by another layer of indirection [footnote with xD]
- let's just assume that api is at /api
- and have the frotend nginx server redirect the request to wherever the backend actually is
- adds a tiny little bit of latency, but hey it shouldn't matter that much and it scales well
- turns out the "stock" nginx Docker image has a built-in template utility [link]
- so that:
```docker
FROM nginx:beloved-tag
COPY ./dist/* /usr/share/nginx/html/
```

becomes

```docker
FROM nginx:beloved-tag
COPY ./templates/* /etc/nginx/templates/
COPY ./dist/* /usr/share/nginx/html/
```

and if you're one of the mupptes that complains about Docker image size and layer count - zip it!

the template is:
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

and the whole container is configured with (Nomad example):

```hcl
env {
  BACKEND_URL = "https://api.example.com"
}
```

## [yyyyyy]

- how to point to resources to allow url path nesting
- as a devops if you have to ran an "unknown" app - just let it have it's own subdomain


## Epilogue

- 
- if you have better ideas feel free to reach out to me and I'll gladly enhance this post (with a proper shoutout)
