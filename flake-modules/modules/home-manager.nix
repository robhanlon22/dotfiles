{
  inputs,
  pkgs,
  username,
  homeDirectory ?
    if pkgs.stdenv.isDarwin
    then "/Users/${username}"
    else "/home/${username}",
  stateVersion ? "23.11",
  homeModule,
  ...
}: {
  imports = [
    ../../home-manager
    homeModule
    inputs.nixvim.homeManagerModules.nixvim
    inputs.stylix.homeModules.stylix
  ];
  home = {
    inherit username homeDirectory stateVersion;
  };
  _module.args.pkgs = pkgs.lib.mkForce pkgs;
}
