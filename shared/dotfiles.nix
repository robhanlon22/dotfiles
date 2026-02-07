{
  update = dir: "(cd ${dir} && nix flake update)";

  switch = dotfiles: cmd: let
    inherit (dotfiles) base config;
    update = dir: "(cd ${dir} && nix flake update)";
  in "${update base} && ${update config} && ${cmd} switch --flake ${config}";
}
