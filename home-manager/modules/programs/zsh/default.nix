{
  pkgs,
  config,
  ...
}: {
  imports = [./nix.nix ./init-extra.nix];

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
    plugins = let
      zsh-utils = pkgs.fetchFromGitHub {
        owner = "belak";
        repo = "zsh-utils";
        rev = "main";
        hash = "sha256-6oLTTY+eUl8VcKpSRQa4tTmERhSaQ8rLirUD9OOL7wg=";
      };
    in [
      {
        name = "completion";
        src = "${zsh-utils}/completion";
      }
      {
        name = "history";
        src = "${zsh-utils}/history";
      }
      {
        name = "editor";
        src = "${zsh-utils}/editor";
      }
      {
        name = "utility";
        src = "${zsh-utils}/utility";
      }
      {
        name = "git";
        src = "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git";
      }
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
    ];
    sessionVariables = rec {
      EDITOR = "${config.programs.nixvim.package}/bin/nvim";
      VISUAL = EDITOR;
      GPG_TTY = "$(tty)";
      FAST_WORK_DIR = "${config.xdg.configHome}/fsh";
    };
    initExtra = "source ${./zshrc}";
    shellAliases = {
      ls = "ls --color=auto";
    };
  };

  xdg.configFile."fsh/themes/catppuccin-mocha.ini" = {
    enable = true;
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/zsh-fsh/main/themes/catppuccin-mocha.ini";
      sha256 = "7eIiR+ERWFXOq7IR/VMZqGhQgZ8uQ4jfvNR9MWgMSuk=";
    };
  };
}
