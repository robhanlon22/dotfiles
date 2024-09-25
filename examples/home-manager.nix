{
  description = "Dotfiles";

  outputs = inputs @ {
    dotfiles,
    flake-parts,
    pre-commit,
    ...
  }: let
    system = "x86_64-linux";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [pre-commit.flakeModule];
      systems = [system];
      flake = dotfiles.lib.${system}.homeManagerConfiguration {
        username = "rob";
        overlays = [];
        homeModule = ./home.nix;
      };
      perSystem = {config, ...}: {
        pre-commit.settings.hooks = {
          alejandra.enable = true;
          deadnix.enable = true;
          statix.enable = true;
          "~git-diff" = {
            enable = true;
            name = "git-diff";
            description = "Show git diff when files have been changed";
            entry = "git diff --color --exit-code";
            always_run = true;
            pass_filenames = false;
            require_serial = true;
          };
        };
        devShells.default = config.pre-commit.devShell;
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
