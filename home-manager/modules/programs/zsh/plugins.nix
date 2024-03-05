{pkgs, ...}: {
  programs.zsh = {
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
    initExtra = ''
      fast-theme -q XDG:themes/catppuccin-mocha
      compstyle zshzoo
    '';
  };

  xdg.configFile."fsh/themes/catppuccin-mocha.ini" = {
    enable = true;
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/zsh-fsh/main/themes/catppuccin-mocha.ini";
      sha256 = "7eIiR+ERWFXOq7IR/VMZqGhQgZ8uQ4jfvNR9MWgMSuk=";
    };
  };
}
