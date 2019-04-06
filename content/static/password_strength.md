---
title: "Password security"
date: 2019-04-06T22:25:37+02:00
draft: false
type: post
url: passwords
---

## So... What do you know about passwords?
<div style="height: 15em;"></div>

## Why should I care?
- [have I been pwned?](https://haveibeenpwned.com/)
<div style="height: 15em;"></div>

## Preface
<a href="https://xkcd.com/936/" target="_blank">![](https://imgs.xkcd.com/comics/password_strength.png)</a>

<div style="height: 7em;"></div>

## Authentication

- the other aspect is: authorization

### Authentication factor

- copy
- give

### MFA
- something you own
- something you know
- something you are
<div style="height: 8em;"></div>

## Attacks and mitigations

### Non-technical

- embarrassingly trivially personal password => just don't
- shoulder surfing => look behind your back ;)
- note attached to your monitor => OMG. just don't, please - it's still better than ~~Twilight~~ password reuse
- rubber hose cryptanalysis => don't store the password in your head

### Bots

- phishing => stay on your toes, do phishing training and mock attacks
- data leaks => use unique passwords, salt email + (if you can) make sure your data is securely stored
- brute-force / dictionary attacks => high password entropy 

### Technical

- burn you SIM card and start running. NOW!

<div style="height: 10em;"></div>

## So... the password

- unique
- fresh
- not trivially personal
- encrypted at rest as well as in transit
- "hard to guess" => high entropy

<div style="height: 10em;"></div>

## Olgierd, but how?

Well, security is a process...

### Use a password manager
- [keepassxc](https://keepassxc.org/)
- [lastpass](https://www.lastpass.com/) <- I use this one

### Chicken-egg problem

#### Diceware

- Kerckhoffs's principle
- humans are bad at `/dev/random`
- [a list](https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt)

<div style="height: 10em;"></div>

## How strong is YOUR password?
<div style="overflow: hidden; width: 80vw;"><iframe style="margin-top: -200px; width:100%; height: 100vh; overflow: hidden;" scroll="no" src="https://lowe.github.io/tryzxcvbn#search-bar"></iframe></div>
