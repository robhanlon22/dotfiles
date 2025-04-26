{
  description = "Dotfiles";

  outputs = inputs @ {
    dotfiles,
    flake-parts,
    pre-commit,
    ...
  }: let
    system = "aarch64-darwin";
    lib = dotfiles.lib.${system};
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [pre-commit.flakeModule];

      systems = [system];

      flake = lib.darwinSystem {
        username = "rob";
        hostname = "jazz";
        overlays = [];
        configurationModule = ./configuration.nix;
        homeModule = ./home.nix;
      };

      perSystem = {config, ...}: {
        config = {
          pre-commit.settings.hooks = lib.preCommitHooks;
          devShells.default = config.pre-commit.devShell;
        };
      };
    };

  inputs = {
    dotfiles.url = "github:robhanlon22/dotfiles";
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      follows = "dotfiles/nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      follows = "dotfiles/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    pre-commit = {
      url = "github:cachix/pre-commit-hooks.nix";
      follows = "dotfiles/pre-commit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
