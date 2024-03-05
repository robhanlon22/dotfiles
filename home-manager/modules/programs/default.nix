{
  imports = [./kitty ./nixvim ./starship ./zsh];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fzf = {enable = true;};
    gpg = {enable = true;};
    home-manager = {enable = true;};
    nixvim = {enable = true;};
    ripgrep = {enable = true;};
    zoxide = {enable = true;};
  };
}
