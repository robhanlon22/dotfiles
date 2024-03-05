{
  config,
  pkgs,
  ...
}: let
  inherit (config.my.lib) shellIntegrations;
in {
  imports = [./kitty ./nixvim ./starship ./zsh];

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "Catppuccin-mocha";
      };
      themes = {
        Catppuccin-mocha = {
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme";
            hash = "sha256-qMQNJGZImmjrqzy7IiEkY5IhvPAMZpq0W6skLLsng/w=";
          };
        };
      };
    };

    carapace =
      shellIntegrations
      // {
        enable = true;
      };

    direnv =
      shellIntegrations
      // {
        enable = true;
        nix-direnv.enable = true;
      };

    nushell.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    gpg.enable = true;

    ripgrep.enable = true;

    zoxide =
      shellIntegrations
      // {
        enable = true;
      };
  };
}
