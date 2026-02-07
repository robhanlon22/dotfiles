{
  imports = [
    ./my.nix
    ./modules/home-manager.nix
  ];

  # Keep lightweight HM from owning shell init by default.
  programs.zsh.enable = false;
}
