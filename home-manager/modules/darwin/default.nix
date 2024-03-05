{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./hammerspoon ./sketchybar ./yabai.nix];

  config = lib.my.modules.ifDarwin {
    home = {
      packages = with pkgs; [
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
        font.size = 16;
        settings = {
          macos_option_as_alt = "left";
          macos_titlebar_color = "background";
          shell = "${config.programs.zsh.package}/bin/zsh -il";
        };
      };

      zsh.plugins = {
        name = "macos";
        src = pkgs.fetchFromGitHub {
          owner = "zshzoo";
          repo = "macos";
          rev = "main";
        };
      };
    };

    launchd.enable = true;
  };
}
