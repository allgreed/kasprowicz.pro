# kasprowicz.pro
My semi-professional webpage

## Usage
No idea why would you want to, but if you must go for [dev](#dev)

## Should you have a personal website
If you're reading this then yes.

### Should you have a personal website even though you don't have much to convey
Yes. First say whatever. Then say better things.

### Ok, but how?
You can totally have a simillar kind of website, for simplicity I recommend a free tier hosting that comes with a domain name (mine from OVH at the time of writting), then somehow generate html files (either by hand or via Hugo) and put them there (manually). There. Iterate, automate, improve.

## Dev

### Prerequisites
- [nix](https://nixos.org/nix/manual/#chap-installation)
- `direnv` (`nix-env -iA nixpkgs.direnv`)
- [configured direnv shell hook ](https://direnv.net/docs/hook.html)
- some form of `make` (`nix-env -iA nixpkgs.gnumake`)

Hint: if something doesn't work because of missing package please add the package to `default.nix` instead of installing it on your computer. Why solve the problem for one if you can solve the problem for all? ;)

Also: if the direnv doesn't is work properly *and* it is installed via nix-env -> make sure your profile is sourced in your shellrc (`source ~/.nix-profile/etc/profile.d/nix.sh`).

### One-time setup
```
make init
```

### Everything
```
make help
```
