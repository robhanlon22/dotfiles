{lib, ...}: {
  imports = [./kitty ./nixvim ./starship ./zsh];

  programs = lib.my.config.enabledAll {
    direnv = {};
    fzf = {};
    gpg = {};
    home-manager = {};
    nixvim = {};
    ripgrep = {};
    zoxide = {};
  };
}
