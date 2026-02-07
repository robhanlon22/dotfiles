{
  inputs,
  lib,
  pkgs,
  username,
  homeDirectory ?
    if pkgs.stdenv.isDarwin
    then "/Users/${username}"
    else "/home/${username}",
  stateVersion ? "23.11",
  baseHomeModule ? ../../home-manager/lightweight.nix,
  homeModule,
  localHomeModule ? ../../local/home-manager.nix,
  localNvimConfig ? ../../local/nvim,
  extraHomeModules ? [],
  ...
}: {
  imports =
    [
      baseHomeModule
      homeModule
      inputs.stylix.homeModules.stylix
    ]
    ++ lib.optionals (builtins.pathExists localHomeModule) [localHomeModule]
    ++ extraHomeModules;
  home = {
    inherit username homeDirectory stateVersion;
  };
  _module.args = {
    pkgs = pkgs.lib.mkForce pkgs;
    inherit localNvimConfig;
  };
}
