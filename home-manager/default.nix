{
  system,
  nixpkgs,
  nixvim,
  home-manager,
  nur,
  ...
}: args @ {
  username,
  stateVersion ? "23.11",
  modules ? [],
  overlays ? [],
  ...
}: let
  pkgs = args.pkgs or nixpkgs.legacyPackages.${system};

  homeDirectory =
    args.homeDirectory
    or (
      if pkgs.stdenv.isDarwin
      then "/Users/${username}"
      else "/home/${username}"
    );

  baseModule = {
    home = {
      inherit username homeDirectory stateVersion;
    };

    nixpkgs = {
      config.allowUnfree = true;
      overlays = [nur.overlay] ++ overlays;
    };
  };
in {
  homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules =
      [
        baseModule
        nixvim.homeManagerModules.nixvim
        ./home.nix
      ]
      ++ modules;
  };
}
