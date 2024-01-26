{
  description = "Home Manager configuration of deck";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-lib.url = "github:nixos/nixpkgs/nixos-unstable?dir=lib";
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
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          {
            home = {
              inherit username homeDirectory;
              stateVersion = "23.11";
            };

            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                (_self: _super: {
                  cljstyle = cljstyle.packages.${system}.default;
                })
              ];
            };
          }
          nixvim.homeManagerModules.nixvim
          ./home.nix
        ] ++ modules;
      };
  };
}
