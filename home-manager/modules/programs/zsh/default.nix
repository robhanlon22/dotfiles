{
  config,
  my,
  ...
}: {
  imports = [./nix.nix ./plugins.nix];

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
    shellAliases = {
      cddb = "cd ${my.dotfiles.base}";
      cddc = "cd ${my.dotfiles.config}";
      ls = "ls --color=auto";
      cat = "bat";
    };
    initContent = builtins.readFile ./zshrc;
  };
}
