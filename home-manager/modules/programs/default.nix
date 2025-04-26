{my, ...}: {
  imports = [./kitty ./nixvim ./ssh.nix ./starship ./zsh];

  programs = with my; {
    bat.enable = true;

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

    ssh.enable = true;

    zoxide =
      shellIntegrations
      // {
        enable = true;
      };
  };
}
