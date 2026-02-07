{pkgs, ...}: {
  imports = [./antifennel.nix];

  home.packages = with pkgs; let
    bunx = package: ''
      ${pkgs.bun}/bin/bunx -y ${package} "$@"
    '';
  in [
    _1password-cli
    cmake
    devenv
    fd
    fennel-ls
    ffmpeg
    gh
    jq
    lame
    luaPackages.fennel
    nerd-fonts.caskaydia-cove
    nodejs
    openai
    rsync
    ruby
    sqlite
    tree-sitter
    wormhole-william
    yt-dlp
    (writeShellScriptBin "codex" (bunx "@openai/codex"))
    (writeShellScriptBin "repomix" (bunx "repomix"))
  ];
}
