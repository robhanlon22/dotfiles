{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    home.packages = with pkgs; [xsel wl-clipboard];

    programs = {
      nixvim = {
        globals = {
          sqlite_clib_path = "${pkgs.sqlite.out}/lib/libsqlite3.so";
        };
        clipboard.providers = {
          xsel.enable = true;
          wl-copy.enable = true;
        };
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
