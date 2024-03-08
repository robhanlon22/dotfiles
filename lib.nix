{
  config,
  lib,
  ...
}: {
  options.my.lib = lib.mkOption {
    type = lib.types.submodule {
      freeformType = with lib.types; attrsOf anything;
    };
  };

  config = {
    my.lib = {
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
