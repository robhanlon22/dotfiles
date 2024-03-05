{
  pkgs,
  lib,
  ...
}: {
  config = lib.my.modules.ifLinux {
    home.packages = [pkgs.xsel];

    programs = {
      nixvim.clipboard.providers.xsel.enable = true;
      kitty = {
        font.size = 14;
        settings = {
          wayland_titlebar_color = "background";
        };
      };
    };

    fonts.fontconfig.enable = true;
  };
}
