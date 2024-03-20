{
  my,
  pkgs,
  ...
}: {
  imports = [./kitty ./nixvim ./starship ./zsh ./wezterm];

  programs = with my; {
    bat = let
      theme = "Catppuccin Mocha";
    in {
      enable = true;
      config = {
        inherit theme;
      };
      themes.${theme}.src = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme";
        hash = "sha256-F781wNpM/3rSC4csJfVmuSCwlWXycXzbIPLzg4LXv6s=";
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
