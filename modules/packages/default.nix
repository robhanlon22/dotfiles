{ pkgs, lib, ... }:

{
  config.nixpkgs.overlays = [
    (_self: _super:
      lib.pipe ./. [
        lib.my.directories
        (map (path: {
          name = builtins.baseNameOf path;
          value = pkgs.callPackage path { };
        }))
        builtins.listToAttrs
      ])
  ];
}
