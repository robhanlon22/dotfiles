{
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    system,
    ...
  }:
    with lib; {
      options.lib.darwinSystem = with types;
        mkOption {
          type = functionTo anything;
          readOnly = true;
        };

      config = mkIf pkgs.stdenv.isDarwin {
        lib.darwinSystem = {
          hostname,
          username,
          homeDirectory ? "/Users/${username}",
          configurationModule,
          ...
        } @ args: let
          modules = import ./modules.nix (args // {inherit inputs pkgs;});

          darwinConfiguration = inputs.nix-darwin.lib.darwinSystem {
            modules = [
              {
                # Set Git commit hash for darwin-version.
                system.configurationRevision = self.rev or self.dirtyRev or null;
                users.users.${username}.home = homeDirectory;
                nix.settings.trusted-users = [username];
                nixpkgs.hostPlatform = system;
              }
              modules.nixpkgs
              ../nix-darwin
              configurationModule
              inputs.home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username} = modules.home-manager;
                };
              }
            ];
          };
        in {
          darwinConfigurations.${hostname} = darwinConfiguration;
          inherit (darwinConfiguration) pkgs;
        };
      };
    };
}
