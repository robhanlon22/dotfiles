{ lib, ... }:

{
  my = rec {
    directories = path:
      lib.pipe path [
        builtins.readDir
        (lib.attrsets.filterAttrs (_k: v: v == "directory"))
        builtins.attrNames
        (map (name: path + /${name}))
      ];
    nixvim = rec {
      leader = "<leader>";
      keymap = let mkMod = m: k: "<${m}-${toString k}>";
      in {
        leader = k: "${leader}${k}";
        alt = mkMod "A";
        ctrl = mkMod "C";
      };
    };
    attrsets = rec {
      fromList = nameFn: valueFn: list:
        builtins.listToAttrs (map (el: {
          name = nameFn el;
          value = valueFn el;
        }) list);
      fromNames = fromList lib.id;
    };
    enable = attrsets.fromNames (lib.const { enable = true; });
  };
}
