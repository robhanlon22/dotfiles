{
  pkgs,
  lib,
  ...
}:
lib.my.modules.whenDarwin {
  imports = [./hammerspoon];

  config = {
    home = {
      packages = with pkgs; [
        raycast
        pinentry_mac
      ];
      file.".gnupg/gpg-agent.conf".text = ''
        pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      '';
    };

    programs.zsh.initExtra = builtins.readFile ./zshrc;
  };
}
