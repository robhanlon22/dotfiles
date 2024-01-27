{ pkgs, lib, ... }:

{
  imports = lib.my.directories ./modules;

  home = {
    packages = with pkgs; [
      antifennel
      caskaydia-cove-nerd-font
      cljstyle
      clojure
      coreutils
      fd
      fnm
      gh
      git
      jdk11_headless
      jenv
      jq
      kitty
      leiningen
      nodejs
      rbenv
      ruby
      ruby-build
      wormhole-william
    ];

    file.".editorconfig".source = ./editorconfig;
  };

  xdg.configFile = {
    "stylua/stylua.toml" = {
      enable = true;
      source = ./stylua.toml;
    };
    "nix/nix.conf" = {
      enable = true;
      source = ./nix.conf;
    };
  };

  programs = {
    fzf.enable = true;
    kitty = {
      enable = true;
      font = {
        name = "Caskaydia Cove Nerd Font Mono";
        size = 16;
      };
      settings = {
        macos_option_as_alt = "left";
        shell = "$HOME/.nix-profile/bin/zsh --interactive --login";
        tab_bar_style = "powerline";
        tab_powerline_style = "round";
        window_padding_width = 5;
      };
      theme = "Dracula";
    };
    nixvim.enable = true;
    ripgrep.enable = true;
    starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
    zoxide.enable = true;
    home-manager.enable = true;
    gpg.enable = true;
  };
}
