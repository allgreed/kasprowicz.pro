+++
title = "Common Makefile Interface"
date = 2021-07-10T19:29:41+02:00
description = ""
draft = true
categories = [""]
tags = ["", ""]
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

Obviously no SDLC is the same, though many are alike. You may doodle on a board(white or black), peace of paper, tablet or directly on the walls (deranged Silicon Valley genius style!). You may use [cri-o](https://cri-o.io/), [podman](https://podman.io/), rkt (it this even alive? o.0) or something that doesn't yet exist at the time of writting. My point: your respective parts of SDLC looks somewhat like this or at least you wish they were.

#### Note: but embedded!

Fully agreed, this post is targeted mostly at ~backend ~application ~developers. Turns out they're not that different from you, dear embedder. You may still learn a lot from this. For now, consider "Docker container image" to be what it truly is - just a bunch of arranged bytes.

### The gap between your things
There is a part of the process though that misses out on such formalization and convergence. See this:

![Devops, various developer and manager interact bi-directionally with the development stage](/missing-interface.png)

Various developers (having different machines, potentially different OSes), devops (think: smart, but not invested in that particullar project) and a ~technical manager (think: invested in a project but with little technical expertise - can ran commands from tutorial, but won't fix errors or quickly flopnax the ropjar using rilkef). Someone is bound to ask:

> How do you actually run this thing?

And it will turn out that the README is outdated. The wiki page is missing a dependency. For unit tests. The database needs migration. You've confused the order of steps in the instruction. Do you start over? Is the process indempotent?

I've seen things. Particullarly this. Too. Many. Times.

At various companies, be it big or small. Developers with or without CS degree . This is a serious problem that I belived we (the people) are capable of solving.

## Missing interface requiremenets

<!-- TODO: inerface requiremenets -->
<!-- TODO: using Makefile + how it fullfils the requiremenets + prior art (Apdziu + Doom) -->
<!-- TODO: companions and how they fit into the model -->
<!-- TODO: in depth description +  -->
<!-- TODO: some examples - Digitalocean Token Scoper + learning django -->
<!-- TODO: side effects - scripting / automation culture + README template-->

<!-- TODO: call to action! -->
<!-- TODO: write description -->
<!--TODO: spec on Github-->
## Footnotes
[^1]: the graph and the one below bears an uncanny simillarity to [the meaning of meaning](https://www.researchgate.net/publication/242914013_The_meaning_of_meaning)
