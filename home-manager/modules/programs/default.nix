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
    wezterm = {
      enable = false;
      enableZshIntegration = true;
      extraConfig = ''
        return ${lib.nixvim.toLuaObject {
          color_scheme = "Catppuccin Mocha";
          font = lib.nixvim.mkRaw ''wezterm.font("CaskaydiaCove Nerd Font Mono")'';
          font_size = 18.0;
          use_fancy_tab_bar = false;
          window_decorations = "RESIZE";
          tab_bar_at_bottom = true;
        }}
      '';
    };
    zathura = {
      enable = false;
      options = {
        font = "CaskaydiaCove Nerd Font Mono 16";
      };
      extraConfig = "include catppuccin-mocha";
    };
    zoxide = {};
  };

  xdg.configFile."zathura/catppuccin-mocha" = {
    enable = false;
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-mocha";
      hash = "sha256-/HXecio3My2eXTpY7JoYiN9mnXsps4PAThDPs4OCsAk=";
    };
  };
}
