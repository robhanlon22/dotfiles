{ lib, ... }:

{
  imports = lib.my.directories ./.;

  programs =
    lib.my.enable [ "fzf" "gpg" "home-manager" "nixvim" "ripgrep" "zoxide" ];
}
