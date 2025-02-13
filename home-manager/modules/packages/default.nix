{pkgs, ...}: {
  imports = [./antifennel.nix];

  home.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    fd
    fennel
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
