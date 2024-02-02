{
  pkgs,
  lib,
  ...
}: {
  imports = [./kitty ./nixvim ./starship ./zsh];

  programs = lib.my.config.enabledAll {
    direnv = {};
    fzf = {};
    gpg = {};
    home-manager = {};
    nixvim = {};
    ripgrep = {};
    zathura = {
      options = {
        font = "CaskaydiaCove Nerd Font Mono 16";
      };
      extraConfig = "include catppuccin-mocha";
    };
    zoxide = {};
  };

  xdg.configFile."zathura/catppuccin-mocha".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-mocha";
    hash = "sha256-/HXecio3My2eXTpY7JoYiN9mnXsps4PAThDPs4OCsAk=";
  };
}
