{
  config,
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
          shell = "${config.programs.zsh.package}/bin/zsh";
        };
      };
    };

    fonts.fontconfig.enable = true;
  };
}
