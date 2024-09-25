{
  inputs,
  overlays ? [],
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
  nixpkgs.nixpkgs = {
    config.allowUnfree = true;
    overlays = [inputs.nur.overlay] ++ overlays;
  };

  home-manager = {
    imports = [
      ../home-manager
      homeModule
      inputs.nixvim.homeManagerModules.nixvim
      inputs.stylix.homeManagerModules.stylix
    ];
    home = {
      inherit username homeDirectory stateVersion;
    };
  };
}
