{
  pkgs,
  lib,
  ...
}: {
  config = lib.my.modules.ifLinux {
    home.packages = with pkgs; [xsel wl-clipboard];

    programs = {
      nixvim.clipboard.providers = {
        xsel.enable = true;
        wl-copy.enable = true;
      };
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
