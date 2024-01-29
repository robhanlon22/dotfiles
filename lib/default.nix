{lib, ...}: {
  my = rec {
    nixvim = {
      keymap = let
        mkMod = m: k: "<${m}-${toString k}>";
      in rec {
        leader = "<leader>";
        leader- = k: "${leader}${toString k}";
        alt- = mkMod "A";
        ctrl- = mkMod "C";
        wk = {
          group = name: attrs: {inherit name;} // attrs;
          vim = command: desc: ["<cmd>${toString command}<cr>" desc];
          lua = fn: desc: [(lib.nixvim.mkRaw fn) desc];
        };
      };
    };

    attrsets = {
      fromList = f: list: builtins.listToAttrs (map f list);
      merge = a: b: a // b;
    };

    config = rec {
      enabling = attr: attrsets.merge {${attr} = true;};
      enabled = enabling "enable";
      enablingAll = attr: builtins.mapAttrs (lib.const (enabling attr));
      enabledAll = enablingAll "enable";
    };
  };
}
