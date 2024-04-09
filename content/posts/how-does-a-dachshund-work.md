+++
title = "How Does a Dachshund Work"
date = 2024-04-09T14:09:11+02:00
description = "Case study of the essence of hacking on a small scale"
draft = true
+++

## Intro

I like trains. I've been on one lately, reading [some hackernews in the morning](https://news.ycombinator.com/item?id=39903738). "Los Alamos" they said. [Los Alamos chess](https://en.wikipedia.org/wiki/Los_Alamos_chess).
Interdansting. Specifically the 3rd game interested me. How did they end up in a such a position? I'd like to see it unfold.

I could've play it out over the board. I didn't have a chessboard with me then though.
I could've... click it over or build a visualisation thingy or...

I'm certainly capable. "Too slow" flashed through my mind.

But could I...

## The hack

just use readymade chess tools?

I'd need to somehow fit the Los Alamos board onto an ordinary board, but that's easy, just ignore 2 files and ranks.

Question: [can I make a PGN start from a certain position?](https://www.reddit.com/r/chess/comments/ugsrq1/can_i_make_a_pgn_start_from_a_certain_position/).  
Answer: [Yes](https://en.wikipedia.org/wiki/Portable_Game_Notation#Optional_tag_pairs) - the PGN format allows for inputing a starting FEN

Ok, now. How do I FEN? [There's one already](https://lig-membres.imag.fr/prost/MiniChessResolution/LosAlamos/index.html). Also: a stockfish mod to play Los Alamos Chess

...however it doesn't work with the 3rd game recording from wikipedia.  
So I used [this ](https://www.dailychess.com/chess/chess-fen-viewer.php) to create a starting FEN by hand-moving every piece by (-1, -1): 
```
8/8/rnqknr2/pppppp2/8/8/PPPPPP2/RNQKNR2 w - - 0 1
```

Input into a [random PGN viewer](https://chesstempo.com/pgn-viewer/) and...  
it works... until the queen promotion on move 21. Becasue it happens on a 6th rank, which is illegal. But that also means that the setup optional feature is supported with this viewer correctly.

But were it to happen on 8th rand all would be fine and dandy, so... vector calculation goes brrrrrrrr.
 
What I gotta do is move everything by (2, 0), ergo 2 ranks.

FEN is straight forward as I can just swap the ranks around in text (didn't feel like doing it by hand in the editor again):
```
rnqknr2/pppppp2/8/8/PPPPPP2/RNQKNR2/8/8 w - - 0 1
```

For the actual game I needed some vim-fu:
```vim
:s/ /\r/g
" manualy seperate the check / "+" from the end and =Q, as well as "#", also add @, so that "+" lines becomes "@+"
" I know... this sounds complex, however just trust me ;d
qa$j|q
40@a
" it stops at every @+ line, but again, there's only 6 of them, so: just rinse and repeat until the end
" select all via V
J
:s/ @//g
" ^ that's why I've added the @ then, makes it trivial to rejoin properly
```

Tiny bit of manual snags - whitespace around promotion notation o.0 and the wikipedia game recording not being strictly PGN (excess "1-0" at the end). Add the metadata, et voila:

```toml
[Event "Los Alamos trials"]
[Site "Los Alamos, New Mexico USA"]
[Date "1956.??.??"]
[Round "3"]
[White "MANIAC I"]
[Black "Beginner"]
[Result "1-0"]
[FEN "rnqknr2/pppppp2/8/8/PPPPPP2/RNQKNR2/8/8 w - - 0 1"]
[SetUp "1"]

1.d5 {Moves are transposed by 2 ranks, original was d3, etc} b6 2.Nf5 d6 3.b5 e6 4.Ne3 a6 5.bxa6 Nxa6 6.Kd4 Nc5 7.Nxc5 bxc5+ 8.Kd3 f6 9.a5 Rb8 10.a6 Ra8 11.a7 Kd7 12.Qa5 Qb7 13.Qa4+ Ke7 14.Rb3 Rxa7 15.Rxb7 Rxa4 16.Rb3 Ra7 17.f5 Ra6 18.fxe6 c6 19.Nf5+ Kd8 20.e7+ Kd7 21.exf8=Q Nc7 22.Qxd6+ Kc8 23.Ne7#
```

## Aftermath

And it was worth it, interesting game - from computer chess history perspective at least. Gotta appreciate the bong-cloud-ish thingy on move 6!

Why this writeup even exists? It's not exactly groundbreaking. Though short - it illustrates how a hacker might go about solving problems. Going down a rabbit hole, evaluting trade-offs, repurposing tools. There's also this *aikido* notion of leaverage. I felt like through minimal force I've cause an effect comparable to writing a custom chess frontend. Additionally: I sometimes struggle to given an example of how a hacker or a shaman might benefit someone's endeavour. It's not a great example - I'm not there yet, but it's one of the best personal ones I've had lately. That there's a way out of the false dichotomy **of** sacrificing the issue on the altar of corporate profit ("not our priority right now") **or** commiting obscene ammount of resources to it.

There. I did **it** again.

The next best approximation is this animation from the 70s: [How Does a Dachshund Work](https://www.youtube.com/watch?v=r16GL3N4PdM)
