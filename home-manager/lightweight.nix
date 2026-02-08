{
  imports = [
    ./my.nix
    ./modules/home-manager.nix
    ./modules/programs/ghostty.nix
    ./modules/programs/neovim
  ];

  # Keep lightweight HM from owning shell init by default.
  programs.zsh.enable = false;
}
