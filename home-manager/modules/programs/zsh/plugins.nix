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

    script = name: dir: {inherit name dir;};

    zshUtil = name: script "${name}.plugin" "${zsh-utils}/${name}";

    ohMyZsh = name: dir:
      script name "${pkgs.oh-my-zsh}/share/oh-my-zsh/${dir}";
    ohMyZshLib = name: ohMyZsh name "lib";
    ohMyZshPlugin = name: ohMyZsh "${name}.plugin" "plugins/${name}";

    sourceScripts = lib.concatMapStringsSep "\n" ({
      name,
      dir,
    }: ''
      source '${dir}/${name}.zsh'
    '');

    pluginsBeforeCompInit = [
      (zshUtil "completion")
      (zshUtil "editor")
    ];

    plugins = [
      (zshUtil "history")
      (zshUtil "utility")
      (ohMyZshPlugin "git")
      (ohMyZshLib "directories")
      (ohMyZshLib "spectrum")
      (script
        "fast-syntax-highlighting.plugin"
        "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions")
    ];
  in {
    initExtraBeforeCompInit = sourceScripts pluginsBeforeCompInit;
    initExtra = lib.mkBefore ''
      ${sourceScripts plugins}
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
