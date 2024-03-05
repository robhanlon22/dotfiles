{
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

    programs.kitty = {
      font.size = 16;
      settings = {
        macos_option_as_alt = "left";
        macos_titlebar_color = "background";
      };
    };

    launchd.enable = true;
  };
}
