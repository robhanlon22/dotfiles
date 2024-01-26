{ pkgs, lib, ... }:

{
  config.programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      initExtra = builtins.readFile ./zshrc;
      shellAliases = { ls = "ls --color"; };
    };

    fzf.enableZshIntegration = true;
    kitty.shellIntegration.enableZshIntegration = true;
    starship.enableZshIntegration = true;
    zoxide.enableZshIntegration = true;
  };
}
