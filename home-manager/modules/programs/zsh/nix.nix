{
  config,
  lib,
  pkgs,
  ...
}: let
  zshShared = import ../../../../shared/zsh.nix {inherit lib pkgs;};
in {
  programs.zsh.shellAliases = zshShared.mkUpdateAliases config.my.dotfiles;
}
