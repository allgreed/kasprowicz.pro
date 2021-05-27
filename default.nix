{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    hugo
    git
    gnumake 
    ncftp
  ];
}
