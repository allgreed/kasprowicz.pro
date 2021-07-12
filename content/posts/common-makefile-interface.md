+++
title = "Common Makefile Interface"
date = 2021-07-10T19:29:41+02:00
description = ""
draft = true
categories = [""]
tags = []
+++

> He had eyes all around his head and spoke magic words that could turn the day sky in night sky and night sky into day sky...

## Rationale

<abbr title="Software Development Life Cycle">SDLC</abbr> has numerous definitions and ways to dissect it, let's asume the following for the sake of an argument:

![because of **need** a piece of software is *deisgned*, *developed* and *ran* in hope to have some **affect** on the external world](/sdlc-overview.png)[^1]

It's obviously not that simple - the model expands across time with numerous sub-dependencies etc.:

![Version 0.1.1 contains it's own stages as well as 0.1.2... ad inifinitum](/sdlc-time.png)

### Interfaces

But that's not the part of SDLC I want to talk about today! I'm more interested in how the pieces fit togheter. The **interfaces**. So an example could look like this:

![Development stage is fed ugly doodles or a tracker ticket and spits out Docker container images](/interface.png)

If the concept above **doesn't** cause you to shake and tremble in search of a comment section (spoiler alert: there isn't one) to begin a rant -  feel free to skip the "note:" sections

#### Note: what do I mean by Docker

Obviously no SDLC is the same, though many are alike. You may doodle on a board(white or black), piece of paper, tablet or directly on the walls (deranged Silicon Valley genius style!). You may use [cri-o](https://cri-o.io/), [podman](https://podman.io/), rkt (it this even alive? o.0) or something that doesn't yet exist at the time of writting. My point: your respective parts of SDLC looks somewhat like this or at least you wish they were.

#### Note: but embedded!

Fully agreed, this post is targeted mostly at ~backend ~application ~developers. Turns out they're not that different from you, dear embedder. You may still learn a lot from this. For now, consider "Docker container image" to be what it truly is - just a bunch of arranged bytes.

### The gap between your things
There is a part of the process though that misses out on such formalization and convergence. See this:

![Devops, various developer and manager interact bi-directionally with the development stage](/missing-interface.png)

Various developers (having different machines, potentially different OSes), devops (think: smart, but not invested in that particullar project) and a ~technical manager (think: invested in a project but with little technical expertise - can ran commands from tutorial, but won't fix errors or quickly flopnax the ropjar using rilkef). Someone is bound to ask:

> How do you actually run this thing?

And it will turn out that the README is outdated. The wiki page is missing a dependency. For unit tests. The database needs migration. You've confused the order of steps in the instruction. Do you start over? Is the process idempotent?

I've seen things. Particularly this. Too. Many. Times.

At various companies, be it big or small. Developers with or without CS degree . This is a serious problem that I belived we (the people) are capable of solving.

## The mess
<!-- TODO: better section title-->

Currently the gap is filled by development specific tools, like `yarn` for <abbr title="Single Page Application">SPA</abbr>s (or is it `npm` now?), `maven` for Java apps and `cargo` for Rust. This causes cognitive overhead and prevents standardization.

The problem calls for:
- technology agnostic interface (so: one tool for JS, Java, Rust...)
- interoperability with whatever is used underneath
- self-documenting solution

Furthermore, following standardized features would be required:
- single (yet tweakable) way of getting the app started with sensible defaults 
- running unit-tests
- running static analysis
- spitting out the container
- building the app (if applicable)

## Along comes [GNU]Make!

Remember [Make](https://en.wikipedia.org/wiki/Make_(software))? With a [GNU flavour](https://www.gnu.org/software/make/)! Turns out that while it's quite decent a compiling C, but that's not the point - it can be used as a sensible enough-cross platform task runner[^2].

The [`.PHONY:`](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html) directive can be used for defining non-file targets.

```Makefile
.PHONY: run setup

run: setup ## run the app
	@echo "Not implemented"; false

setup:
```

Upon `make run` this will execute `setup` and then `run`. You can obviously put targets that are actual files into the mix.

### Small idea
```Makefile
.PHONY: run lint test container build env-up env-down env-recreate 
```

A defined set of targets for actions that are commonly done with software. Independent of the undeylaying technology, yet interoprable with any concrete task runner (like the aformentioned `yarn`). It's not about *replacement* - those tools work just fine. It's about **adding another layer**.

![developers, manager and devops all use `make run` which can be implmeneted by many different Makefiles for many different apps in development](/unified-action.png)

Imagine all the agents (or stakeholders... or just people) interacting with any project in a well-defined standardized manner. Obviously you may want to tweak the configuration at some point - use different database setup, etc. But there will come a time for anyone invested in the project to just get the app running. For many it will be one of their last encounter with that particullar piece of software.

A devops can be in a hurry to fix a bug, but the project in question is a dependency. She need's to run it with debug tracing enabled. `make run`, then a quick `Makefile` examination to figure out which particular flag to turn. Done!

I'll leave other scenarios like:
- a manager (technical enough to ran few shell commands) wants to quickly see the very latest pre-staging version
- an intern is being onboarded into the company
- open source

as an excercise for the reader.

### Note on prior art

It's not like I woke up some day and decided to do things this way. This a reflection and formalization on what I've been doing myself for the last ~2 years while working for 3 distinct employers[^3].

Furthermore, Make is a mature tool, first appeared in 1976, so around 40+ years ago[^3]. Originated to solve the problem of forgetting to recompile (remember the stuff about C?). It's readily avaible (and might be even preinstalled) on any unix-like platoform. Makefiles are here to stay.

> Quote here.
>
 —  <cite>Benjamin Franklin</cite>

### Early design notes
<!--TODO: should this section be here?-->
I strongly belive that it's the case of agreeing on something rather than bikesheding about the shape of that something

![XKCD 927 / How Standards Proliferate - (See: A/C chargers, character encodings, instant messaging, etc.); Situation: There are 14 competing standards.; Cueball: 14?! Ridiculous! We need to develop one universal standard that covers everyone's use cases. Ponytail: Yeah!; Soon: Situation: There are 15 competing standards.](https://imgs.xkcd.com/comics/standards.png)

yet I hold a firm belief (until proven otherwise) that following concepts are sensible:
- having the formalized targets begin with a different letters, so that autocomplete experiance is nicer - `make r[tab]` vs `make run`
- breaking the Makefile convention of the default target being recepie that builds all possible outputs and having it be `help` instead - that'll prevent accidental builds as well as gracefully show the possibilities to someone experianced with Makefiles
- the formalized targets being simple English words like `run, build, help` rather than `launch, manufacture, assistance`

## Companions
<!-- TODO: companions (nix, entr, direnv) and how they fit into the model -->
## Case studies
<!-- TODO: some examples - Digitalocean Token Scoper + learning django -->

## Misc
<!-- TODO: intrdouce this section -->

### Self-documentation
```Makefile
help: ## print this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
    | awk 'BEGIN {FS = ":.*?## "};
    {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help
```

### Tooling-culture


### Always up to date!

### CI

### Glue - intialization hook
```Makefile
init: ## one time setup
	direnv allow .
```

### Utilities
```Makefile
todo: ## list all TODOs in the project
	git grep -I --line-number TODO \
    | grep -v 'list all TODOs in the project' \
    | grep TODO
```

### README - not starting from scratch!

<!--stamps-->
<!--https://www.technovelty.org/tips/the-stamp-idiom-with-make.html-->

## Call to action!
<!-- TODO: call to action! -->

### Implement
<!-- TODO: link to repo template-->
<!--TODO: spec on Github - validating -->
<!-- TODO: do the badge and validator and expose it as a service - commit to both django-example as well as digitalocean token scoper -->

### Contribute
<!--TODO: spec on Github - issues -->

<!-- TODO: write description -->
<!--Feedback-->
<!--TODO: problem wielu środowisk-->
## Footnotes
[^1]: the graph and the one below bears an uncanny simillarity to [the meaning of meaning](https://www.researchgate.net/publication/242914013_The_meaning_of_meaning)
[^2]: here are [some tutorials](https://makefiletutorial.com/)
[^3]: at the time of writing
