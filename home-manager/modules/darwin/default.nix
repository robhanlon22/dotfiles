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

    launchd.enable = true;
  };
}
