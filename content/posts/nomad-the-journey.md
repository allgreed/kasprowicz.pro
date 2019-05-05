+++
title = "Nomad - the journey"
date = 2019-05-02T14:49:10+01:00
description = "When docker-compose doesn't quite cut it and k8s is way too much"
categories = ["nomad"]
draft = true
+++

## Why do you even...?
I'm the [BOFH](https://en.wikipedia.org/wiki/Bastard_Operator_From_Hell) of servers at the [local hackerspace](https://hs3.pl/). Before Nomad our server setup looked like [this](https://github.com/hs3city/squire/tree/fc4c12ada57aee92e667a4ec92db3ee530b54477). On top of Ansible there was quite unusual layer of application orchestration and setup. It involved an Ansible role with some `docker-compose` sprinkled on top in a non-kosher manner. This was hard to maintain as anyone who wanted to launch cool apps on our infrastructure had to get acquainted with this bizarre construct. Furthermore, there was no easy way of testing locally if the application would launch as desired in production environment. The setup was not scalable beyond a single machine. This clearly wasn't a way to go.

It came to me that we need one more tool to manage our containers and the problems I've encountered were a result of underabstraction. So... what one can use to orchestrate containers you ask? Kuberneters, of course! Nah - running the whole thing on a single machine just for the sake of spinning up a few services seamed like an overkill. 

In the mean time I've noticed some chatter going on the hackerspace Slack `#dev_ops_sys_admin` channel. People were curious about the new thing from Hashicorp - Nomad. It caught my attention as well and, since no one had any prior experience with this tool, I've decided to see if it would meet the needs of the infrastructure I was in charge of.

## Humble beginings
### Hashi resources
### Lab setup
### Initial conclusions

## Let's get prodish!
### Ansible role
### Securing connection [needs work]
### Monitoring [needs work]
### Life goes on...

## Thoughts
### Modularity
### Scaling (down)
### Vendor lock-in?
### Overhead [needs work]
### Databases
### State of the art

## Uncommon how-tos
I had a problem with those
### Logs preview
### Binding static ports
### Local Docker setup [needs work]
### Propper advertising / bind address configuration [needs work]
### How to purge jobs form nomad [needs work]

Notes:
- no idea if it's any good for multi DC cluster

## Shoutout & goodstuff
- DO code
- [hhes](https://github.com/xaxes) - for ???
