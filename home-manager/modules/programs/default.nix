{
  imports = [
    ./kitty
    ./nixvim
    ./ssh.nix
    ./starship
    ./zsh
  ];

  programs = {
    bat.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    gpg.enable = true;

    mise.enable = true;

    ripgrep.enable = true;

    ssh.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
