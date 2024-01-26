{ pkgs, specialArgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [ ./modules/nixvim ./modules/mac ];

  home = {
    inherit (specialArgs) username homeDirectory;

    stateVersion = "23.11";

    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      (callPackage ./packages/antifennel.nix { })
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
  };

  xdg.configFile = {
    "stylua/stylua.toml" = {
      enable = true;
      source = ./stylua.toml;
    };
  };

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    kitty = {
      enable = true;
      font = {
        name = "Caskaydia Cove Nerd Font Mono";
        size = 16;
      };
      settings = {
        window_padding_width = 5;
        tab_bar_style = "powerline";
        tab_powerline_style = "round";
      };
      shellIntegration.enableZshIntegration = true;
      theme = "Dracula";
    };

    nixvim.enable = true;

    ripgrep.enable = true;

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      shellAliases = { ls = "ls --color"; };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    home-manager.enable = true;
  };
}
