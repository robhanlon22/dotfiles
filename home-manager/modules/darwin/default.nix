{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hammerspoon
    ./lib.nix
    ./sketchybar
    ./yabai.nix
  ];

  config = with pkgs;
    lib.mkIf stdenv.isDarwin {
      home = {
        packages = [
          coreutils
          findutils
          raycast
        ];

        file.".gnupg/gpg-agent.conf".text = ''
          pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
        '';
      };

      programs = {
        kitty = {
          keybindings = {
            "cmd+t" = "new_tab_with_cwd";
            "cmd+enter" = "new_window_with_cwd";
          };

          settings = {
            macos_option_as_alt = "left";
            macos_titlebar_color = "background";
            shell = "${config.programs.zsh.package}/bin/zsh -il";
          };
        };

        nixvim.globals.sqlite_clib_path = "${sqlite.out}/lib/libsqlite3.dylib";
      };

      launchd.enable = true;
    };
}
