{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = let
    zsh-utils = pkgs.fetchFromGitHub {
      owner = "belak";
      repo = "zsh-utils";
      rev = "main";
      hash = "sha256-6oLTTY+eUl8VcKpSRQa4tTmERhSaQ8rLirUD9OOL7wg=";
    };
    plugins = [
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
    sourcePlugin = {
      name,
      src,
    }: ''
      source '${src}/${name}.plugin.zsh'
    '';
  in {
    initExtra = ''
      ${lib.concatMapStringsSep "\n" sourcePlugin plugins}
      compstyle zshzoo
    '';
  };

  home.activation = let
    setFastTheme = pkgs.writeShellScript "set-fast-theme" ''
      source "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh"
      fast-theme -q XDG:themes/catppuccin-mocha
    '';
  in {
    fastTheme = "${config.programs.zsh.package}/bin/zsh ${setFastTheme}";
  };

  xdg.configFile."fsh/themes/catppuccin-mocha.ini" = {
    enable = true;
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/zsh-fsh/main/themes/catppuccin-mocha.ini";
      hash = "sha256-7eIiR+ERWFXOq7IR/VMZqGhQgZ8uQ4jfvNR9MWgMSuk=";
    };
  };
}
