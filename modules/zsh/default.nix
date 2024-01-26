{ lib, ... }:

{
  config.programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      initExtra = lib.strings.concatMapStringsSep "\n\n" builtins.readFile [
        ./zshrc
        (builtins.fetchurl {
          url =
            "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/8be4789bbbef06fe5eed581dc8c58df51e3cd9fd/plugins/git/git.plugin.zsh";
          sha256 = "1cy65hwk028wz5896157lr5m3vgb9l4b61bzkykz3sb9jmcdc930";
        })
      ];
      shellAliases = { ls = "ls --color"; };
    };

    fzf.enableZshIntegration = true;
    kitty.shellIntegration.enableZshIntegration = true;
    starship.enableZshIntegration = true;
    zoxide.enableZshIntegration = true;
  };
}