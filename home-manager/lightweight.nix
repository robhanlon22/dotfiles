{
  imports = [
    ./my.nix
    ./modules/home-manager.nix
    ./modules/programs/ghostty.nix
  ];

  # Keep lightweight HM from owning shell init by default.
  programs.zsh.enable = false;
}
