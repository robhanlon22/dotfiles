{pkgs, ...}: {
  imports = [./antifennel.nix];

  home.packages = with pkgs; [
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
    sqlite
    wormhole-william
    yt-dlp
  ];
}
