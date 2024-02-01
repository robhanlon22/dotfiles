{
  description = "HM builder";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    nur.url = "github:nix-community/NUR";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    pre-commit = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cljstyle = {
      url = "path:flakes/cljstyle";
      # url = "github:robhanlon22/hm?dir=flakes/cljstyle";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
      };
    };
  };

  outputs = inputs @ {
    flake-parts,
    pre-commit,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [pre-commit.flakeModule];
      systems = import systems;

      flake.lib = {
        mkDarwinConfiguration = import ./nix-darwin inputs;
        mkHomeManagerConfiguration = import ./home-manager inputs;
      };

      perSystem = {pkgs, ...}: {
        pre-commit.settings.hooks = {
          alejandra = {enable = true;};
          deadnix = {enable = true;};
          editorconfig-checker = {enable = true;};
          fnlfmt = {
            enable = true;
            name = "fnlfmt";
            description = "Run fnlfmt on Fennel files";
            files = "\\.fnl$";
            entry = "${pkgs.fnlfmt}/bin/fnlfmt --fix";
          };
          luacheck = {enable = true;};
          prettier = {
            enable = true;
            files = "\\.(md|json|yaml|yml)$";
          };
          statix = {enable = true;};
          stylua = {enable = true;};
          taplo = {enable = true;};
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
      };
    };
}
