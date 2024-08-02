{
  config,
  lib,
  ...
}: {
  options.my = with lib;
    mkOption {
      type = with types;
        submodule {
          freeformType = attrsOf anything;
        };
    };

  config = {
    my = {
      trace = v: builtins.trace v v;
      attrsets = {
        fromList = f: list: builtins.listToAttrs (map f list);
        merge = a: b: a // b;
      };
      dotfiles = {
        base = "~/Documents/dotfiles";
        config = "~/.config/dotfiles";
      };
    };

    _module.args = {
      inherit (config) my;
    };
  };
}
