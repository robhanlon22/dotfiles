{lib, ...}: let
  inherit (lib.my) shellIntegrations;
in {
  imports = [./kitty ./nixvim ./starship ./zsh];

  programs = {
    atuin =
      shellIntegrations
      // {
        enable = true;
        settings = {
          inline_height = 30;
          keymap_mode = "auto";
          update_check = false;
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
