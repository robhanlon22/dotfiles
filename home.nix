args@{ pkgs, specialArgs, ... }:

let
  util = load ./util.nix;
  load = path: import path (args // { inherit load util; });
in {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ (load packages/overlay.nix) ];
  };

  imports = util.directories ./modules;

  home = {
    inherit (specialArgs) username homeDirectory;

    stateVersion = "23.11";

    packages = with pkgs; [
      antifennel
      caskaydia-cove-nerd-font
      cljstyle
      coreutils
      fd
      gh
      git
      gnupg
      kitty
      nodejs
      ruby
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
    starship.enable = true;
    zoxide.enable = true;
    home-manager.enable = true;
  };
}
