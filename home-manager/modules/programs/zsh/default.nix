{
  config,
  lib,
  pkgs,
  ...
}: let
  zshShared = import ../../../../shared/zsh.nix {inherit lib pkgs;};
in {
  imports = [
    ./nix.nix
    ./plugins.nix
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    defaultKeymap = "viins";
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
    };
    sessionVariables = rec {
      EDITOR = "${config.home.profileDirectory}/bin/nvim";
      VISUAL = EDITOR;
      GPG_TTY = "$(tty)";
      FAST_WORK_DIR = "${config.xdg.configHome}/fsh";
    };
    shellAliases = zshShared.mkBaseAliases config.my.dotfiles;
    initContent = builtins.readFile ../../../../shared/zshrc;
  };
}
