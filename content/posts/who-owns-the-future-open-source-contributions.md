+++
title = "Who Owns the Future Open Source Contributions"
date = 2024-09-29T20:56:13+02:00
description = "Practical, real-world ways of contributing to open source + some musings"
draft = true
+++

> We do not thrive as parts of a machine. We are intended by nature to be diverse, to do diverse things, to have many skills. We only need to fear being replaced by robots, if we live like robots.

—  <cite>John Seymour, also: **not** John Seymour</cite>
<!--TODO: description?-->

## Drone - perseverance

## <s>Hot</s>Hubstuff - communication

<!--!!!-->
<!--TODO - mine to the left, theirs to the right-->
<!--TODO - also write a commentary -->
<!--!!!-->
### On Thu, Jun 27, 2024 at 7:49 PM, I wrote:  
To Whom It May Concern,

I'm unable to simply download the app (on https://hubstaff-production.s3.amazonaws.com/yadayada I get a 403 error).

And this is a problem because:  
1. it complicates packaging the app  
you see, someone was so kind to [do it for you](https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/misc/hubstaff/default.nix) (unless it's actually you guys - then hats off!) - except it doesn't work now, because there's this token thingy with your website and I'd have to figure out how to automate this and it's just such a hassle  
2. it really messes up reproducibility, because well, you cannot pin a specific version  

Would you be so kind as to make this possible again? On your side it's a simple flip from *"deny"* to *"allow"* on some AWS policy and that'll make me quite happy with your company, because the software is decent. I've been using it for some time now and the todo feature is quote cool.

Kind regards,  
Lord Olgierd Kasprowicz

### They replied:
Hello Olgierd,

Your ticket is now escalated to my tech team under Ticket Number 2890027865 | High Priority

However, could you confirm that you are downloading the app from our
website here: Download Hubstaff <https://app.hubstaff.com/download>.

Having successfully installed the application, I am not very sure how to
replicate this. Could you please let me know? GThis will help me explain
this even more to our developers.

I look forward to your response. If you need any further assistance, please
do not hesitate to contact me.

#### Few minutes later:

Hi Olgierd,

I was able to finally replicate this. Unfortunately, you would not have
access to this link indeed as it is inaccessible to the wider audience.
Please use this link below to download the specific build [secret link was here]

### Me again:

Dear Mercy,

this **absolutely helps** and is a step closer towards a shared better
future! Thank you!

Opportunity: **if and only if you have a Nix / NixOs person on your team** feel free to ask them if they want to upstream [my patch](https://github.com/allgreed/nixos-config/commit/7402b23e8285b5094e5b3ca2b3845cb2aaf66063) to nixpkgs for 2137 points worth of street cred. Just to reiterate - **you've done plenty already and I'm super grateful.** I'm going to do this myself anyway [in ~month or so I think], just letting you know ;)

Last but not least: going *forward* it would be really great to have a authentication-free publicly available immutable url for upcoming releases - this way updating the package would be just a change of url, version and hash.

many thanks once again,  
Lord Olgierd Kasprowicz

### And for the grande finale:

Happy news from me. First, our
developers were able to confirm that unfortunately, this is not something
that they can maintain at this time.

However, I am very happy to let you know that the Client desktop app team
lead reached out to the maintainers,Michal Rus <m@michalrus.com>, and
Sergei Khoma <srghma@gmail.com> to make updates to it. They discussed more
improvements, notably removing the faulty link that was causing the desktop
app not to be downloaded. You can see more updates here;
https://github.com/NixOS/nixpkgs/pull/325417

Thanks again for reaching out! I hope these updates make life much easier
and smooth while using Hubstaff.

## The future
Idea: removing stuff is creating value - Opal
