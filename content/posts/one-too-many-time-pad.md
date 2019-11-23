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

The reason I'm telling you this is because few years ago I've entertained myself with the idea of compression schemes (run-length encoding if I recall correctly) that would allow to "conserve" the key and then use the save key bits to send more key, which in principle would alleviate the pain of secure key exchange once the key has been exhausted (physically giving someone a thumb drive is still state of the art in that regard). I guess it's like reinventing a perpetual motion machine of the third kind - an attempt to change the world without cleaning your room (that is reading a few papers) first.

A curious hacker would ask: what *exactly* happens when you reuse a key? Well, let's find out!

## The model and prior art

I assume message \\(M = (m_1, m_2, ..., m_n)\\) where \\(m\\) is an alphabetic ASCII character or a space and a key \\(K = (k_1, k_2, ..., k_o, k_1, k_2, ..., k_o, ..., k_p)\\) where \\(k\\) is a single byte and  \\(p \leqslant  o \\). ASCII character is assumed to span a single byte as well. We assume that the unique key length \\(o\\) is known.

The ciphertext \\(C\\) is obtained as follows:
$$C_i = M_i \oplus K_i $$

[Crib dragging](https://travisdazell.blogspot.com/2012/11/many-time-pad-attack-crib-drag.html) can be utilised after splitting the message into \\(\left \lceil n \over o \right \rceil\\) chunks. You can even [try it online!](https://www.cribdrag.com/)

We can also split the ciphertext into \\(o\\) chucks by taking every \\(j\\)-th character, where \\(0 < j < o\\), crack them independently and then join. In that case \\(j\\)-th chuck would have the form of:
$$(M\_{j} \oplus K_j, M\_{o + j} \oplus K_j, M\_{2o + j} \oplus K_j, ...)$$

The only unknown required to compute the key for a chunk is a single plaintext character from said chunk:
$$ K_j = C_j \oplus M\_{j} $$

### Take a step back

Can we use frequency analysis to find the plaintext character? Absolutely, since in-chunk cipher function is an injection! Here's the proof:

{{< highlight py >}}
#!/usr/bin/env python3
possible_keys = range(0, 256)
possible_plaintexts = list(range(ord('A'), ord('z') + 1)) + [ord(' ')]

result_spaces = [{ p^k for p in possible_plaintexts} for k in possible_keys]

assert all(map(lambda s: len(s) == len(possible_plaintexts), result_spaces))
{{< /highlight >}}

Drawbacks? The chunk must be long enough for the frequency statistics to be meaningful and the character distribution has to be known; that would fail for a message that is written in more than one language, partly [hog latin](https://en.wikipedia.org/wiki/Pig_Latin), etc.

## I'm in space!

There is another approach we can take to find a known character that does not require knowledge of letter distribution - we can find the spaces!

Knowing that \\( C_j \oplus C\_{o+j} = M_j \oplus K_j \oplus M\_{o+j} \oplus K_j = M_j \oplus M\_{o+j} \\) we've got the xor of the plaintexts. This doesn't provide much information in itself, since xor is commutative - \\( M_j \oplus M\_{o+j} = M\_{o+j} \oplus M\_{j} \\).

Looking closely at the bit patterns of xored characters we can distinguish 2 groups of interest: \\(space \oplus a = 0b0\textbf{1}0xxxxx \\), \\(a \oplus b = 0b0\textbf{0}0xxxxx \\), where \\(a, b \in \\{ a..z \\}, x \in \mathbb{B}\\)

After finding \\( p, r, s \\) such that:
$$\begin{cases}
 & \text{} C_p \oplus C\_{r} = 0b0\textbf{0}0.....\\\\ 
 & \text{} C\_{r} \oplus C\_{s} = 0b0\textbf{1}0.....
\end{cases}$$

From the first equation we can derive the conclusion that \\(M_r\\) is **not** a space and the second equation tells us that one of \\((M_r, M_s)\\) is a space, which combined implies that \\( M\_{s}  \\) is a space. Game over.

\\( p, r, s \\) can be found as long as the chunk contains at least 2 distinct non-space characters and a single space.

This method can be extended to include uppercase ASCII characters as well (and maybe even *some* special characters such as "@").

## Proofs
<!-- add proof for triplets -->

<!-- TODO: refactor - make it more mathy -->
<!-- TODO: what is solvable? -->
As for the entire chunk:

0. Sequence consisting of 2 distinc non-space characters and a single space is solvable
1. Prepending or appending any permitted element to a solvable sequence \\(s \\) creates a solvable sequence \\(s'\\), since the same triplet can be selected from \\(s' \\) as is used to solve \\( s \\)

## The naïve approach
Why not take every distinct triplet from the ciphertext and check every permutation, huh?

<!-- Add code -->

### Remarks

- todo
- algorithm complexity
- it's performing pretty well on sample texts
<!-- TODO: insert plot -->

## Possible improvements

- todo
- ensuring that the running time is linear -> just describe some clever heuristics



## Appendix A: On LaTeX in Hugo
- todo
- sorry for the Javascript
- official docs
- massive PITA in the begging

{{< highlight html >}}
\\( expr \\) <!-- inline expression -->
$$ expr $$ <!-- block expression -->

exprA\_{exprB} <!-- note the backslash! subscript -->
\\{ expr \\} <!-- note the double backslash! Set containing expr members -->
{{< /highlight>}}

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
