{
  lib,
  pkgs,
}: let
  dotfilesLib = import ./dotfiles.nix;
  fastSyntaxHighlighting = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting";

  catppuccinFastTheme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/zsh-fsh/main/themes/catppuccin-mocha.ini";
    hash = "sha256-YuiWhbgxlIZRlLBB0ut5ge5KLmnPrqgrBhQ7PUswYU4=";
  };

  zsh-utils = pkgs.fetchFromGitHub {
    owner = "belak";
    repo = "zsh-utils";
    rev = "main";
    hash = "sha256-lO3+Pa8YjQaVkuD93fgO2AOcWN5JvNIBxBDu9+0ck48=";
  };

  script = name: dir: {inherit name dir;};
  zshUtil = name: script "${name}.plugin" "${zsh-utils}/${name}";
  ohMyZsh = name: dir: script name "${pkgs.oh-my-zsh}/share/oh-my-zsh/${dir}";
  ohMyZshLib = name: ohMyZsh name "lib";
  ohMyZshPlugin = name: ohMyZsh "${name}.plugin" "plugins/${name}";
in {
  inherit catppuccinFastTheme fastSyntaxHighlighting;

  sourceScripts = scripts:
    lib.concatMapStringsSep "\n" (
      {
        name,
        dir,
      }: ''
        source '${dir}/${name}.zsh'
      ''
    )
    scripts;

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
    (script "fast-syntax-highlighting.plugin" fastSyntaxHighlighting)
  ];

  mkBaseAliases = dotfiles: {
    cddb = "cd ${dotfiles.base}";
    cddc = "cd ${dotfiles.config}";
    ls = "ls --color=auto";
    cat = "bat";
  };

  mkUpdateAliases = dotfiles: {
    hmup = dotfilesLib.switch dotfiles "home-manager";
    ndup = dotfilesLib.switch dotfiles "sudo darwin-rebuild";
  };
}
