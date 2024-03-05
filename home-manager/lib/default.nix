{
  pkgs,
  lib,
  nixvim,
  ...
}: let
  args = {inherit pkgs lib;};
in {
  my = {
    callPackages = paths: args: map (path: pkgs.callPackage path args) paths;
    trace = v: builtins.trace v v;

    shellIntegrations = {
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    attrsets = import ./attrsets.nix args;
    darwin = import ./darwin.nix args;
    modules = import ./modules.nix args;
    nixvim = import ./nixvim.nix args;

    strings = {
      toTitle = str:
        with lib; let
          first = substring 0 1 str;
          rest = substring 1 (stringLength str) str;
        in "${toUpper first}${rest}";
    };
  };
  nixvim = import "${nixvim}/lib/helpers.nix" {
    inherit pkgs lib;
    _nixvimTests = false;
  };
}
