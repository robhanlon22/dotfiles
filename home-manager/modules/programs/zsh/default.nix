{
  imports = [./nix.nix ./init-extra.nix];

  programs.zsh = {
    enable = true;
    antidote = {
      enable = true;
      plugins = [
        # This comes first!
        "zsh-users/zsh-completions"

        # Then the simple utils.
        "belak/zsh-utils path:completion"
        "belak/zsh-utils path:history"
        "belak/zsh-utils path:editor"
        "belak/zsh-utils path:utility"

        # And the rest of the fun plugins :)
        "jeffreytse/zsh-vi-mode"
        "ohmyzsh/ohmyzsh path:plugins/brew"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "zdharma-continuum/fast-syntax-highlighting"
        "zsh-users/zsh-autosuggestions"
      ];
    };
    enableCompletion = false;
    initExtra = "source ${./zshrc}";
    shellAliases = {
      ls = "ls --color";
    };
  };

  xdg.configFile."fsh/catppuccin-mocha.ini" = {
    enable = true;
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/zsh-fsh/main/themes/catppuccin-mocha.ini";
      sha256 = "7eIiR+ERWFXOq7IR/VMZqGhQgZ8uQ4jfvNR9MWgMSuk=";
    };
  };
}
