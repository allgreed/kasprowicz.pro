+++
title = "One-Too-Many-Time Pad"
date = 2019-11-19T23:35:17+01:00
description = ""
draft = true
categories = [""]
tags = ["university"]
+++

## Prologue

It's been a while. Recently I've started a cryptography course at the university and this correlates with people asking me about cryptography. But of course correlation is not causation... Anyway, Scott Hanselman had made an excellent take on the subject of [abiding the DRY rule while passing on knowledge](https://www.hanselman.com/blog/DoTheyDeserveTheGiftOfYourKeystrokes.aspx) and in that spirit I'd like to act out the hero myth; of the one who embarked, explored and came back to talk about one's findings.

## Intro

In the world of mass surveillance *perfect* secrecy sounds like a pretty neat deal, huh? I'm obviously referring to the [one-time pad](https://en.wikipedia.org/wiki/One-time_pad), which was proven to be unbreakable in [this paper](https://web.archive.org/web/20120120001953/http://www.alcatel-lucent.com/bstj/vol28-1949/articles/bstj28-4-656.pdf#) by Claude Shannon (a jolly good fellow by the way - did you know that he pioneered wearable devices in the 60'? o.0). I'd dare to say that Shannon's research influenced our modern notion of semantic security, ~30 years before the term was coined. No free lunches though, perfect security comes with a trade-off - the key *MUST* be at least as long as the plaintext and *MUSTN'T* be reused. 

The reason I'm telling you this is because few years ago I've entertained myself with the idea of compression schemes (run-length encoding if I recall correctly) that would allow to "conserve" the key and then use the save key bits to send more key, which in principle would alleviate the pain of secure key exchange once the key has been exhausted (physically giving someone a thumb drive is still state of the art in that regard). I guess it's like reinventing a perpetual motion machine of the third kind - an attempt to change the world without cleaning your room (that is reading the paper) first.

A curious hacker would ask: what *exactly* happens when you reuse a key? Well, let's find out!

## The model and prior art
