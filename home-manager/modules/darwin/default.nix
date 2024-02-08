{
  pkgs,
  lib,
  ...
}: {
  imports = [./hammerspoon ./sketchybar];

  config = lib.my.modules.ifDarwin {
    home = {
      packages = [pkgs.raycast];

      file.".gnupg/gpg-agent.conf".text = ''
        pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      '';
    };

    programs.zsh.initExtra = builtins.readFile ./zshrc;
  };
}
