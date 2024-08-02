{pkgs, ...}: {
  imports = [./antifennel.nix];

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["CascadiaCode"];})
    fd
    fennel
    flips
    gh
    git
    git-lfs
    jq
    nodejs
    ruby
    sqlite
    wormhole-william
  ];
}
