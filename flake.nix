{
  description = "Home Manager configuration of deck";

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
      url = "path:flakes/cljstyle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, cljstyle, ... }: {
    mkConfig = { system, modules ? [ ], username, homeDirectory }:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = pkgs.lib.extend
          (lib: _: { my = import ./lib { inherit pkgs lib; }; });
      in home-manager.lib.homeManagerConfiguration {
        inherit pkgs lib;
        modules = [
          {
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
          }
          nixvim.homeManagerModules.nixvim
          ./home.nix
        ] ++ modules;
      };
  };
}
