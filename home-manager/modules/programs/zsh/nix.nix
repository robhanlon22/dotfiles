{my, ...}: let
  update = dir: "(cd ${dir} && nix flake update)";
  switch = cmd: "${update my.dotfiles.base} && ${update my.dotfiles.config} && ${cmd} switch --flake ${my.dotfiles.config}";
in {
  programs.zsh.shellAliases = {
    hmup = switch "home-manager";
    ndup = switch "sudo darwin-rebuild";
  };
}
