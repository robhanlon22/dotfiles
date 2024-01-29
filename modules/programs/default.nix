{ lib, ... }:

{
  imports = [ ./kitty ./nixvim ./starship ./zsh ];

  programs = lib.my.config.allEnabled {
    fzf = { };
    gpg = { };
    home-manager = { };
    nixvim = { };
    ripgrep = { };
    zoxide = { };
  };
}
