{
  system,
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
    hostPlatform = system;
    config.allowUnfree = true;
    overlays = [inputs.nur.overlay] ++ overlays;
  };

  home-manager = {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
      ../home-manager
      homeModule
    ];
    home = {
      inherit username homeDirectory stateVersion;
    };
  };
}
