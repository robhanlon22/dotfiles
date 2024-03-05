{
  pkgs,
  lib,
  nixvim,
  ...
}: let
  args = {inherit pkgs lib;};
in {
  my = {
    attrsets = import ./attrsets.nix args;
    callPackages = paths: args: map (path: pkgs.callPackage path args) paths;
    darwin = import ./darwin.nix args;
    modules = import ./modules.nix args;
    nixvim = import ./nixvim.nix args;
    trace = v: builtins.trace v v;
  };
  nixvim = import "${nixvim}/lib/helpers.nix" {
    inherit pkgs lib;
    _nixvimTests = false;
  };
}
