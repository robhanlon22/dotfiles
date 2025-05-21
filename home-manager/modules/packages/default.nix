{pkgs, ...}: {
  imports = [./antifennel.nix];

  home.packages = with pkgs; [
    cargo
    cmake
    fd
    fennel
    ffmpeg
    gh
    git
    git-lfs
    jq
    lame
    nerd-fonts.caskaydia-cove
    nodejs
    rsync
    ruby
    rustc
    rustlings
    sqlite
    wormhole-william
    yt-dlp
  ];
}
