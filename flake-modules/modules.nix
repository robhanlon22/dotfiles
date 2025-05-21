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
}: rec {
  nixpkgs.nixpkgs = {
    config.allowUnfree = true;
    overlays = [inputs.nur.overlays.default] ++ overlays;
  };

  home-manager = {
    imports = [
      nixpkgs
      ../home-manager
      homeModule
      inputs.nixvim.homeManagerModules.nixvim
      inputs.stylix.homeModules.stylix
    ];
    home = {
      inherit username homeDirectory stateVersion;
    };
  };
}
