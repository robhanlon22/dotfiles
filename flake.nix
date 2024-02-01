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
    cljstyle,
    home-manager,
    nixpkgs,
    nixvim,
    nur,
    nix-darwin,
    flake-parts,
    pre-commit,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({self, ...}: {
      imports = [pre-commit.flakeModule];

      systems = import systems;

      flake.lib.mkDarwinConfiguration = {
        system ? "aarch64-darwin",
        hostname,
        username,
        homeDirectory ? "/Users/${username}",
      }: {
        ${hostname} = nix-darwin.lib.darwinSystem {
          modules = [
            (
              {pkgs, ...}: {
                # List packages installed in system profile. To search by name, run:
                # $ nix-env -qaP | grep wget
                environment.systemPackages = [];

                # Auto upgrade nix package and the daemon service.
                services.nix-daemon.enable = true;

                nix = {
                  package = pkgs.nix;
                  settings = {
                    auto-optimise-store = true;
                    # Necessary for using flakes on this system.
                    experimental-features = "nix-command flakes";
                  };
                };

                # Create /etc/zshrc that loads the nix-darwin environment.
                programs.zsh.enable = true; # default shell on catalina

                security.pam.enableSudoTouchIdAuth = true;

                system = {
                  # Set Git commit hash for darwin-version.
                  configurationRevision = self.rev or self.dirtyRev or null;

                  # Used for backwards compatibility, please read the changelog before
                  # changing.
                  # $ darwin-rebuild changelog
                  stateVersion = 4;
                };

                users.users.${username}.home = homeDirectory;

                nixpkgs = {
                  config.allowUnfree = true;
                  hostPlatform = system;
                };
              }
            )
          ];
        };
      };

      flake.lib.mkHomeManagerConfiguration = args @ {
        system ? "aarch64-darwin",
        hostname,
        username,
        stateVersion ? "23.11",
        modules ? [],
        overlays ? [],
        ...
      }: let
        pkgs = args.pkgs or nixpkgs.legacyPackages.${system};
        homeDirectory =
          args.homeDirectory
          or (
            if pkgs.stdenv.isDarwin
            then "/Users/${username}"
            else "/home/${username}"
          );
        lib = nixpkgs.lib.extend (self: _super:
          import ./lib {
            inherit pkgs;
            lib = self;
            nixvim = nixvim.lib.${system};
          });
      in {
        "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs lib;
          modules =
            [
              {
                home = {
                  inherit username homeDirectory stateVersion;
                };

                nixpkgs = {
                  config.allowUnfree = true;
                  overlays =
                    [
                      nur.overlay
                      (_: _: {
                        inherit lib;
                        cljstyle = cljstyle.packages.${system}.default;
                      })
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

      perSystem = {pkgs, ...}: {
        pre-commit.settings.hooks =
          (import ./lib/config.nix {
            inherit (nixpkgs) lib;
          })
          .enabledAll {
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
            prettier = {files = "\\.(md|json|yaml|yml)$";};
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
    });
}
