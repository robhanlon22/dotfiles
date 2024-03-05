{lib, ...}: let
  inherit (lib.my) shellIntegrations;
in {
  imports = [./kitty ./nixvim ./starship ./zsh];

  programs = {
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
