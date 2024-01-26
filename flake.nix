{
  description = "HM builder";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cljstyle = {
      url = "github:robhanlon22/hm?dir=flakes/cljstyle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, cljstyle, ... }: {
    mkConfig = { system, modules ? [ ], username, homeDirectory }:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = pkgs.lib.extend
          (lib: _: { my = import ./lib { inherit pkgs lib; }; });
        base = {
          home = {
            inherit username homeDirectory;
            stateVersion = "23.11";
          };

          nixpkgs = {
            config.allowUnfree = true;
            overlays = [
              (_: _: { cljstyle = cljstyle.packages.${system}.default; })
              (_: _: { inherit lib; })
            ];
          };
        };
      in {
        homeConfigurations.${username} =
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs lib;
            modules = [ base nixvim.homeManagerModules.nixvim ./home.nix ]
              ++ modules;
          };
      };
  };
}
