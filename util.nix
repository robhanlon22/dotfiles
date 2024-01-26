{ lib, ... }:

{
  directories = path:
    lib.pipe path [
      builtins.readDir
      (lib.attrsets.filterAttrs (_k: v: v == "directory"))
      builtins.attrNames
      (map (name: path + /${name}))
    ];
}
