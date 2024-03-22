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
    };

    _module.args = {
      inherit (config) my;
    };
  };
}
