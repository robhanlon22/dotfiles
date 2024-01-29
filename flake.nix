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
    nur.url = "github:nix-community/NUR";
    cljstyle = {
      # url = "path:flakes/cljstyle";
      url = "github:robhanlon22/hm?dir=flakes/cljstyle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { cljstyle, home-manager, nixpkgs, nixvim, nur, ... }: {
    mkConfig = { system, username, homeDirectory, modules, overlays }:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = pkgs.lib.extend (_: super:
          let nixvimLib = { nixvim = nixvim.lib.${system}.helpers; };
          in nixvimLib // (import ./lib {
            inherit pkgs;
            lib = super // nixvimLib;
          }));
        baseModule = {
          home = {
            inherit homeDirectory username;
            stateVersion = "23.11";
          };

          nixpkgs = {
            config.allowUnfree = true;
            overlays = [
              (_: _: { cljstyle = cljstyle.packages.${system}.default; })
              (_: _: { inherit lib; })
              nur.overlay
            ] ++ overlays;
          };
        };
      in {
        homeConfigurations.${username} =
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs lib;
            modules = [ baseModule nixvim.homeManagerModules.nixvim ./home.nix ]
              ++ modules;
          };
      };
  };
}
