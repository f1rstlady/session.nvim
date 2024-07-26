let
  revision = "1e3deb3d8a86a870d925760db1a5adecc64d329d";
  sha256 = "190mb6my29q3gfmcnq64qgw26hkfvdbxwq8929268l3q0qj73pmw";
  nixpkgs = import (fetchTarball {
    name = "nixpkgs";
    url = "https://github.com/NixOS/nixpkgs/archive/${revision}.tar.gz";
    inherit sha256;
  }) { };

in { pkgs ? nixpkgs }:

pkgs.mkShell {
  name = "session.nvim";
  packages = with pkgs; [
    gitlint
    mdformat
    nixfmt-classic
    pre-commit
    selene
    stylua
    yamlfmt
  ];
  shellHook = "pre-commit install -f";
}
