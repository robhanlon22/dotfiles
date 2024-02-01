{
  description = "A tool for formatting Clojure code";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    clj-nix = {
      url = "github:jlesquembre/clj-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    clj-nix,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;

      perSystem = {pkgs, ...}: let
        name = "cljstyle";
        version = "0.16.626";
      in {
        packages.default = clj-nix.lib.mkCljApp {
          inherit pkgs;

          modules = [
            {
              name = "mvxcvi/" + name;
              inherit version;

              lockfile = "${pkgs.writeText "deps-lock.json"
                (builtins.readFile ./deps-lock.json)}";

              projectSrc = pkgs.fetchFromGitHub {
                owner = "greglook";
                repo = name;
                rev = "refs/tags/${version}";
                sha256 = "9Iee9FZq/+ig2cVW+flf9tnXE8LEAbEv9fmQ3P9qf+Y=";
              };

              main-ns = "cljstyle.main";

              nativeImage = {
                enable = true;
                extraNativeImageBuildArgs = ["--no-fallback"];
              };
            }
          ];
        };
      };
    };
}
