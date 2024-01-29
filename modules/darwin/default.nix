{
  pkgs,
  lib,
  ...
}:
lib.mkIf pkgs.stdenv.isDarwin {
  home = {
    packages = with pkgs; [raycast pinentry_mac];
    file.".gnupg/gpg-agent.conf".text = ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
    '';
  };
  programs.zsh.initExtra = builtins.readFile ./zshrc;
}
