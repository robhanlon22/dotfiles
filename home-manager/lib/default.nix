{
  pkgs,
  lib,
  nixvim,
  ...
}: let
  args = {inherit pkgs lib;};
in {
  my = {
    trace = v: builtins.trace v v;
    callPackages = paths: args: map (path: pkgs.callPackage path args) paths;
    nixvim = import ./nixvim.nix args;
    attrsets = import ./attrsets.nix args;
    config = import ./config.nix args;
    modules = import ./modules.nix args;
  };
  nixvim = import "${nixvim}/lib/helpers.nix" {
    inherit pkgs lib;
    _nixvimTests = false;
  };
}
