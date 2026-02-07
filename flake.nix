{
  description = "Dotfiles builder";

  outputs = inputs @ {flake-parts, ...}: let
    systems = [
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./flake-modules
      ];

      inherit systems;

      transposition.lib = {};

      perSystem = {lib, ...}: {
        options.lib = with lib;
          mkOption {
            type = with types;
              submodule {
                freeformType = anything;
              };
          };
      };

      flake.system = builtins.listToAttrs (
        map (system: {
          name = system;
          value = system;
        })
        systems
      );
    };

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
