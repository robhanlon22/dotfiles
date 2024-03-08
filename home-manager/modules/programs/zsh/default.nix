{config, ...}: {
  imports = [./nix.nix ./plugins.nix];

  programs.zsh = {
    enable = true;
    autocd = true;
    defaultKeymap = "viins";
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
    };
    sessionVariables = rec {
      EDITOR = "$HOME/.nix-profile/bin/nvim";
      VISUAL = EDITOR;
      GPG_TTY = "$(tty)";
      FAST_WORK_DIR = "${config.xdg.configHome}/fsh";
    };
    shellAliases = {
      ls = "ls --color=auto";
      cat = "bat";
    };
  };
}
