{
  description = "A tool for formatting Clojure code ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-lib.url = "github:nixos/nixpkgs/nixos-unstable?dir=lib";
    flake-utils.url = "github:numtide/flake-utils";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };
    nix-fetcher-data = {
      url = "github:jlesquembre/nix-fetcher-data";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    clj-nix = {
      url = "github:jlesquembre/clj-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        devshell.follows = "devshell";
        nix-fetcher-data.follows = "nix-fetcher-data";
      };
    };
  };

  outputs = { nixpkgs, flake-utils, clj-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        name = "cljstyle";
        version = "0.16.626";
        lockfile = "${pkgs.writeText "deps-lock.json"
          (builtins.readFile ./deps-lock.json)}";
        projectSrc = pkgs.fetchFromGitHub {
          owner = "greglook";
          repo = name;
          rev = "refs/tags/${version}";
          sha256 = "9Iee9FZq/+ig2cVW+flf9tnXE8LEAbEv9fmQ3P9qf+Y=";
        };
      in {
        packages = {
          default = clj-nix.lib.mkCljApp {
            inherit pkgs;

            modules = [{
              name = "mvxcvi/" + name;

              inherit version projectSrc lockfile;

              main-ns = "cljstyle.main";

              nativeImage = {
                enable = true;
                extraNativeImageBuildArgs = [ "--no-fallback" ];
              };
            }];
          };

        };
      });
}
