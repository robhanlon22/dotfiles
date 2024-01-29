{
  pkgs,
  lib,
  ...
}:
with lib.my.config; let
  zshEnabled = enabling "enableZshIntegration" {};
  initExtras = with builtins; [
    (readFile ./zshrc)
    # Grab oh-my-zsh's git aliases but avoid including the whole plugin
    (readFile (fetchurl {
      url = "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/8be4789bbbef06fe5eed581dc8c58df51e3cd9fd/plugins/git/git.plugin.zsh";
      sha256 = "1cy65hwk028wz5896157lr5m3vgb9l4b61bzkykz3sb9jmcdc930";
    }))
    ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    ''
  ];
in {
  imports = map (initExtra: {programs.zsh = {inherit initExtra;};}) initExtras;
  programs = {
    zsh = enabled {
      enableAutosuggestions = true;
      shellAliases = {ls = "ls --color";};
    };

    direnv = zshEnabled;
    fzf = zshEnabled;
    kitty.shellIntegration = zshEnabled;
    starship = zshEnabled;
    zoxide = zshEnabled;
  };
}
