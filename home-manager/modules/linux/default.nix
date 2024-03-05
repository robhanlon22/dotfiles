{
  pkgs,
  lib,
  ...
}: {
  config = lib.my.modules.ifLinux {
    home.packages = [pkgs.xsel];

    programs.nixvim.clipboard.providers.xsel.enable = true;

    fonts.fontconfig = {
      enable = true;
    };
  };
}
