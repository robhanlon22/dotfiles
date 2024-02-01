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
    nixvim = import ./nixvim.nix args;
    attrsets = import ./attrsets.nix args;
    config = import ./config.nix args;
    modules = import ./modules.nix args;
  };
  nixvim = nixvim.helpers;
}
