let
  pkgs = import (builtins.fetchTree {
    type = "git";
    url = "https://github.com/nixos/nixpkgs/";
    rev = "d74a2335ac9c133d6bbec9fc98d91a77f1604c1f"; # 17-02-2025
    narHash = "sha256-zON2GNBkzsIyALlOCFiEBcIjI4w38GYOb+P+R4S8Jsw=";
    # obtain via `nix-prefetch-git https://github.com/nixos/nixpkgs/ --rev $(git ls-remote https://github.com/nixos/nixpkgs nixos-unstable)`
  }) { config = {}; };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    hugo
    git
    gnumake 
    lftp
  ];
}
