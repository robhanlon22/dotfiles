{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    programs = {
      kitty = {
        settings = {
          shell = "${config.programs.zsh.package}/bin/zsh";
          wayland_titlebar_color = "background";
        };
      };

      nixvim = {
        globals.sqlite_clib_path = "${pkgs.sqlite.out}/lib/libsqlite3.so";

        clipboard.providers = {
          xsel.enable = true;
          wl-copy.enable = true;
        };
      };
    };

    fonts.fontconfig.enable = true;
  };
}
