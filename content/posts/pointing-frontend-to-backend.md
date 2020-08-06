+++
title = "Where's your backend, kiddo?"
date = 2020-07-29T15:25:53+02:00
description = ""
draft = true
categories = [""]
tags = []
+++

## Preface

- seams trivial but this is a supprisingly anoying problem
- static frotnends are welp... static :D
- but you'd like to configure them 

## [yyyyyy]

- how to point to resources to allow url path nesting
- as a devops if you have to ran an "unknown" app - just let it have it's own subdomain

## A nope

- building a version of the app for every environment
- I know some people like it that way
- I believe that the environment dictates certain app behaviour, so it's a no-go

## "runtime config"

- make frontend request a `config.json` from $CURRENT_URL/config.json
- the file contained backend urls and some 3rd party services keys
- mounted the file via k8s ConfigMap
- in retrospection that sucked in a not fun way
- the keys were up for grabs for any malicious agent (actor?)
- additional request
- we had trouble integrating the whole thing into React-Redux lifecycle management - no that's it's hard really, simply the team I was on at the time had a problem with that ;d
- still better than having no way of configuring the fronend and still better love story than twilight

## doshit.sed

- seamed like a reasonable idea a the moment
- as an extention of the CI idea
- what if the "building" could be postponed until the container run
- have the backend URL hardcoded to some #wellknown value and replace it a runtime with sed 
- sed would take the to-be-replace value from envvars and all would be fine
- well it's extremely hacky in not fun way
- templating is hard to get right and prone to errors [example]

## state of the art

- since every problem in computer science can be solved by another layer of indirection [footnote with xD]
- let's just assume that api is at /api
- and have the frotend nginx server redirect the request to wherever the backend actually is
- adds a tiny little bit of latency, but hey it shouldn't matter that much and it scales well
- turns out the "stock" nginx Docker image has a built-in template utility [link]
- so that:
```
FROM nginx:beloved-tag
COPY ./dist/* /usr/share/nginx/html/
```

becomes

```
FROM nginx:beloved-tag
COPY ./templates/* /etc/nginx/templates/
COPY ./dist/* /usr/share/nginx/html/
```

the template is:
```
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

and the whole container is configure with (Nomad example):

```
      env {
        BACKEND_URL = "https://api.example.com"
      }
```

## Epilogue

- sticking with the /api convention (without the whole nginx mambojumbo) seams reasonable at the begining, however from my experiance for the event the most sane default there will exist an even more sensible reason to change that default at some point. Usually 

- if you have better ideas feel free to reach out to me and I'll enhance this post (with a proper shoutout)
