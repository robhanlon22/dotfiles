{
  description = "Dotfiles builder";

  outputs = inputs @ {
    flake-parts,
    pre-commit,
    ...
  }: let
    systems = ["aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux"];
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./flake-modules
        pre-commit.flakeModule
      ];

      inherit systems;

      transposition.lib = {};

      perSystem = {
        config,
        lib,
        ...
      }: {
        options.lib = with lib;
          mkOption {
            type = with types;
              submodule {
                freeformType = anything;
              };
          };

        config = {
          pre-commit.settings.hooks = config.lib.preCommitHooks;
          devShells.default = config.pre-commit.devShell;
        };
      };

      flake.system = builtins.listToAttrs (
        map
        (system: {
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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    pre-commit = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
