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
