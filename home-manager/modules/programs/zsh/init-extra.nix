{
  pkgs,
  lib,
  ...
}: {
  programs.zsh.initExtra =
    lib.pipe [
      # oh-my-zsh git aliases
      (builtins.fetchurl {
        url = "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/8be4789bbbef06fe5eed581dc8c58df51e3cd9fd/plugins/git/git.plugin.zsh";
        sha256 = "1cy65hwk028wz5896157lr5m3vgb9l4b61bzkykz3sb9jmcdc930";
      })

      # oh-my-zsh history setup
      (builtins.fetchurl {
        url = "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/28ed2880c766eb5a360354fb71d597dbc07abaa0/lib/history.zsh";
        sha256 = "0bic1xjkmchzik7av5kmxkcybmddfnidpkrrydqwis7miaqgp3s0";
      })

      # syntax highlighting Catppuccin theme
      "${pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "zsh-syntax-highlighting";
        rev = "main";
        sha256 = "Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
      }}/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"

      # enhanced vi mode
      "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

      # custom config
      ./zshrc
    ] [
      (map (p: "source ${p}"))
      lib.mkMerge
    ];
}
