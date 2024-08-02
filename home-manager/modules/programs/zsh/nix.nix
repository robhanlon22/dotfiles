{my, ...}: let
  update = dir: "(cd ${dir} && nix flake switch)";
  switch = cmd: "${update my.dotfiles.base} && ${update my.dotfiles.config} && ${cmd} switch --flake ${my.dotfiles.config} --show-trace";
in {
  programs.zsh.shellAliases = {
    hmup = switch "home-manager";
    ndup = switch "darwin-rebuild";
  };
}
