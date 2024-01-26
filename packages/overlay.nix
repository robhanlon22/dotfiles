{ pkgs, lib, util, ... }:

_self: _super:
lib.pipe ./. [
  util.directories
  (map (path: {
    name = builtins.baseNameOf path;
    value = pkgs.callPackage path { };
  }))
  builtins.listToAttrs
]
