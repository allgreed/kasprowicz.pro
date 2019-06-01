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

In the mean time I've noticed some chatter going on the hackerspace Slack `#dev_ops_sys_admin` channel. People were curious about the new thing from Hashicorp - [Nomad](https://www.nomadproject.io/). It caught my attention as well and, since no one had any prior experience with this tool, I've decided to see if it would meet the needs of the infrastructure I was in charge of.

<!-- tu skończyłem -->
## Humble beginings
- I'm a sucker for a *good* video tutorial, when new *tool*
- there weren't any tutorials on YouTube / Pluralsight / SafariBooks
- but Hashicorp provides some tutorial articles
    - https://learn.hashicorp.com/nomad/
    - https://www.nomadproject.io/guides/
- also the docs are nice for understanding basic concepts
    - https://www.nomadproject.io/docs/index.html
- also every new tool requires some practice
- practice means lab in this case

### Lab setup
Nothing fancy - I've spun up 3 ubuntu droplets with Terraform

{{< highlight tf >}}
resource "digitalocean_droplet" "srv" {
  count  = 3
  image  = "ubuntu-18-04-x64"
  name   = "srv${count.index}"
  region = "region_closest_to_you"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["you_ssh_key_fingerprint"]
}
{{< /highlight >}}

and added a simple Ansible playbook, mainly for installing Docker:

{{< highlight yaml >}}
---
- hosts: all
  gather_facts: no
  tasks:
    - name: install Python 2
      raw: test -e /usr/bin/python || (apt-get update && apt-get install -y python)
      register: py2installation
      changed_when: py2installation.stdout != ""

- hosts: all
  roles:
    - role: geerlingguy.docker
      docker_package_state: latest
{{< /highlight >}}

[terraform-inventory](https://github.com/adammck/terraform-inventory) was used to generate Ansbile inventory from Terraform state and than some Makefile allowed me to take Nomad for a ride.

## Initial conclustions & novice mistakes
- liked what I saw, especially containing potentially multi-container service description into a single file
- this was the missing abstraction layer
- has potential when we'll expand beyon a single computer
- migrated Hackerspace infrastructure to Nomad (choo, choo! it's the hype train)
- had a few problems that now seams easy, so I'll share what I've found

### Logs preview
- when I did `docker logs` it failed
### Binding static ports
- needed to go through docs to figure it out :c
### How to purge jobs form nomad
- I've initially created a servie that I wanted to become a system job
### Propper advertising / bind address configuration [needs work + investigation]
- simply binding to 0.0.0.0 / 127.0.0.1 didn't work
- binding to outgoing address with advertising it kindof wokrs, but nomad is not accessible by default via cli (not really a problem) and the services need to be avaible over that interface (problem, because I need to specify machine's IP in the config instead of localhost :C)
### Local Docker setup [needs work] ???

## Let's get prodish!
### Ansible role
### Monitoring [needs work]
### Securing connection [needs work]
### Life goes on... [?????]

## Thoughts
### Scaling down
### Overhead [needs work]
### Scaling up
### Scaling up even further
Notes:
- no idea if it's any good for multi DC cluster## State of the art -> try multi DC!!!!
### Modularity
### Vendor lock-in?
Note:
- more than containers
- a priori resource assigning is a pain in the ass

## Shoutout & goodstuff
- DO code
- [hhes](https://github.com/xaxes) - for ???
