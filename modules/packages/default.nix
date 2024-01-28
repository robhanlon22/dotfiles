{ pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (_self: _super:
      (lib.my.attrsets.fromList builtins.baseNameOf
        (path: pkgs.callPackage path { }) (lib.my.directories ./.)))
  ];
}
