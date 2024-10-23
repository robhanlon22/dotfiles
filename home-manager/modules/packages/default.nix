{pkgs, ...}: {
  imports = [./antifennel.nix];

  home.packages = with pkgs; [
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
