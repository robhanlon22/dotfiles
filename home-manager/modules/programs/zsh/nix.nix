let
  flakeDir = "$HOME/.config/dotfiles";
  flakeUpdate = "nix flake update";
  updateAndSwitch = cmd: "(cd ${flakeDir} && ${flakeUpdate} && ${cmd})";
  switch = cmd: "${cmd} switch --flake ${flakeDir} --show-trace";
  nixDarwinSwitch = switch "darwin-rebuild";
  homeManagerSwitch = switch "home-manager";
in {
  programs.zsh.shellAliases = {
    drs = nixDarwinSwitch;
    hms = homeManagerSwitch;
    nfu = flakeUpdate;
    nfudrs = updateAndSwitch nixDarwinSwitch;
    nfuhms = updateAndSwitch homeManagerSwitch;
  };
}
