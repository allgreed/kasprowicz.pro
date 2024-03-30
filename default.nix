let
  nixpkgs = builtins.fetchGit {
    url = "https://github.com/nixos/nixpkgs/";
    ref = "refs/heads/nixos-unstable";
    rev = "b8697e57f10292a6165a20f03d2f42920dfaf973"; # 4-03-2024
  };
  pkgs = import nixpkgs { config = {}; };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    hugo
    git
    gnumake 
    ncftp
    lftp
  ];
}
