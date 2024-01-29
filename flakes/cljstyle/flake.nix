{
  description = "A tool for formatting Clojure code ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    clj-nix = {
      url = "github:jlesquembre/clj-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    clj-nix,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
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

          modules = [
            {
              name = "mvxcvi/" + name;

              inherit version projectSrc lockfile;

              main-ns = "cljstyle.main";

              nativeImage = {
                enable = true;
                extraNativeImageBuildArgs = ["--no-fallback"];
              };
            }
          ];
        };
      };
    });
}
