{
  config,
  pkgs,
  lib,
  ...
}: let
  zshShared = import ../../../../shared/zsh.nix {inherit lib pkgs;};
  inherit (zshShared) sourceScripts fastSyntaxHighlighting;
in {
  programs.zsh = {
    initContent = lib.mkMerge [
      (lib.mkOrder 550 (sourceScripts zshShared.pluginsBeforeCompInit))
      (lib.mkOrder 600 ''
        ${sourceScripts zshShared.plugins}
        compstyle zshzoo
      '')
    ];
  };

  home.activation = let
    setFastTheme = pkgs.writeShellScript "set-fast-theme" ''
      source "${fastSyntaxHighlighting}/fast-syntax-highlighting.plugin.zsh"
      fast-theme -q '${zshShared.catppuccinFastTheme}'
    '';
  in {
    fastTheme = "${config.programs.zsh.package}/bin/zsh ${setFastTheme}";
  };
}
