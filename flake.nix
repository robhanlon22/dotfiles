{
  description = "HM builder";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
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
      lib = import ./lib {
        inherit pkgs;
        nixvim = nixvim.lib.${system};
      };
      defaultOverlays = [
        nur.overlay
        (_: _: {
          inherit lib;
          cljstyle = cljstyle.packages.${system}.default;
        })
      ];
    in {
      lib = rec {
        mkOptions = {
          modules,
          overlays,
          stateVersion ? "23.11",
          ...
        }: {
          inherit pkgs lib;

          modules =
            [
              {
                home = {inherit stateVersion;};
              }
              nixvim.homeManagerModules.nixvim
              {
                nixpkgs = {
                  config.allowUnfree = true;
                  overlays = defaultOverlays ++ overlays;
                };
              }
              ./home.nix
            ]
            ++ modules;
        };

        mkConfig = args @ {
          username,
          homeDirectory,
          hostname,
          ...
        }: let
          options = mkOptions args;
        in {
          homeConfigurations."${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
            inherit (options) pkgs lib;
            modules =
              [{home = {inherit username homeDirectory;};}]
              ++ options.modules;
          };
        };
      };

      checks = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = lib.my.enabledAll {
            alejandra = {};
            deadnix = {};
            editorconfig-checker = {};
            fnlfmt = {
              name = "fnlfmt";
              description = "Run fnlfmt on Fennel files";
              files = "\\.fnl$";
              entry = "${pkgs.fnlfmt}/bin/fnlfmt --fix";
            };
            luacheck = {};
            prettier = {
              files = "\\.(md|json|yaml|yml)$";
            };
            statix = {};
            stylua = {};
            taplo = {};
            "~git-diff" = {
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

      devShells.default = pkgs.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    });
}
