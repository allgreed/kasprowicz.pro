+++
title = "Why Cr on Macs"
date = 2022-02-22T21:06:18+01:00
description = ""
draft = true
categories = [""]
tags = ["", ""]
+++

https://news.ycombinator.com/item?id=30253968

A physical printer (like a dot-matrix one) couldn’t care less whether you told it to CR LF or to LF CR, you’ll end up at the start of the next line either way; neither does a terminal emulator, nornally (but mind the generic kernel terminal driver in between, which normally has the onlcr knob turned on). Apparently some systems even used LF CR as the line terminator. (Bare CR is more well-known, having been used by classic Mac OS, and also makes a bit of sense if you remember the parallel port had an AutoLF line that instructed the attached printer to translate CR to CR LF. I don’t know if that is the actual reason for the convention.)

The caveat is that advancing the paper vertically is relatively fast, but backing up the carriage[1] horizontally can take some time, so on a dumb and slow printer LF CR abc might end up printing abc in the wrong place while the carriage is still moving backwards, while on a smart but slow printer it will just be slower than CR LF abc. I suspect the dumb part is the origin of the CR NUL convention in Net-ASCII[2]; at least both termcap (dC capability) and terminfo (padding machinery) can describe, and curses handles, the possibility that the terminal requires a delay between issuing a CR and printing new characters at the beginning of the line.

[1] It’s a carriage, as in a moving thing that contains useful stuff (cf 3D printers), not a carrier, as in a bare unmodulated signal (cf modems).

[2] https://tools.ietf.org/html/rfc20, which probably takes the prize as the lowest-numbered RFC you could still encounter as an up-to-date reference. 

TODO: let W Bzyl know xD
