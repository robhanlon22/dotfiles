{
  description = "HM builder";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils = {url = "github:numtide/flake-utils";};
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
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

  outputs = {
    self,
    cljstyle,
    home-manager,
    nixpkgs,
    nixvim,
    nur,
    flake-utils,
    pre-commit-hooks,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib.extend (_: super: let
        nixvimLib = {nixvim = nixvim.lib.${system}.helpers;};
      in
        nixvimLib
        // (import ./lib {
          inherit pkgs;
          lib = super // nixvimLib;
        }));
    in {
      lib =
        lib
        // {
          mkConfig = {
            username,
            homeDirectory,
            modules,
            overlays,
          }: {
            homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
              inherit pkgs lib;
              modules =
                [
                  {
                    home = {
                      inherit homeDirectory username;
                      stateVersion = "23.11";
                    };

                    nixpkgs = {
                      config.allowUnfree = true;
                      overlays =
                        [
                          (_: _: {
                            cljstyle = cljstyle.packages.${system}.default;
                          })
                          (_: _: {inherit lib;})
                          nur.overlay
                        ]
                        ++ overlays;
                    };
                  }
                  nixvim.homeManagerModules.nixvim
                  ./home.nix
                ]
                ++ modules;
            };
          };
        };

      checks = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = lib.my.config.enabledAll {
            alejandra = {};
            deadnix = {};
            editorconfig-checker = {};
            luacheck = {};
            prettier = {
              files = "\\.(md|json|yaml|yml)$";
            };
            statix = {};
            stylua = {};
            taplo = {};
          };
        };
      };

      devShells.default = pkgs.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    });
}
