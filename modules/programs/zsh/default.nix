{
  pkgs,
  lib,
  ...
}:
with lib.my.config; let
  source = file: "source ${toString file}";
  zshEnabled = enabling "enableZshIntegration" {};
  zshrc = builtins.readFile ./zshrc;
  omzGitAliases = source (builtins.fetchurl {
    url = "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/8be4789bbbef06fe5eed581dc8c58df51e3cd9fd/plugins/git/git.plugin.zsh";
    sha256 = "1cy65hwk028wz5896157lr5m3vgb9l4b61bzkykz3sb9jmcdc930";
  });
  zshViMode = source "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
  syntaxThemePath = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "zsh-syntax-highlighting";
    rev = "main";
    sha256 = "Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
  };
  syntaxTheme =
    source "${syntaxThemePath}/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
  initExtras = [
    omzGitAliases
    syntaxTheme
    zshViMode
    zshrc
  ];
in {
  imports = map (initExtra: {programs.zsh = {inherit initExtra;};}) initExtras;
  programs = {
    zsh = enabled {
      enableAutosuggestions = true;
      shellAliases = {ls = "ls --color";};
      syntaxHighlighting = enabled {highlighters = ["main" "brackets" "cursor" "root" "line"];};
    };

    direnv = zshEnabled;
    fzf = zshEnabled;
    kitty.shellIntegration = zshEnabled;
    starship = zshEnabled;
    zoxide = zshEnabled;
  };
}
