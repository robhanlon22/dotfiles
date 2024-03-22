{
  description = "Dotfiles builder";

  outputs = inputs @ {
    flake-parts,
    pre-commit,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./flake-modules
        pre-commit.flakeModule
      ];

      systems = import systems;

      transposition.lib = {};

      perSystem = {
        pkgs,
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
          pre-commit.settings.hooks = {
            alejandra.enable = true;
            deadnix.enable = true;
            editorconfig-checker.enable = true;
            fnlfmt = {
              enable = true;
              name = "fnlfmt";
              description = "Run fnlfmt on Fennel files";
              files = "\\.fnl$";
              entry = "${pkgs.fnlfmt}/bin/fnlfmt --fix";
            };
            luacheck.enable = true;
            prettier = {
              enable = true;
              files = "\\.(md|json|yaml|yml)$";
            };
            shellcheck.enable = true;
            shfmt.enable = true;
            statix.enable = true;
            stylua.enable = true;
            taplo.enable = true;
            "~git-diff" = {
              enable = true;
              name = "git-diff";
              description = "Show git diff when files have been changed";
              entry = "${pkgs.git}/bin/git diff --color --exit-code";
              always_run = true;
              pass_filenames = false;
              require_serial = true;
            };
          };

          devShells.default = config.pre-commit.devShell;
        };
      };
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
    systems.url = "github:nix-systems/default";
  };
}
