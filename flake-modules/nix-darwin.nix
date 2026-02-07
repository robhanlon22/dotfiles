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
          enableHomeManager ? true,
          localDarwinModule ? ../local/nix-darwin.nix,
          configurationModule,
          ...
        } @ args: let
          pkgs = import ./modules/nixpkgs.nix (args // {inherit inputs system;});
          home-manager = import ./modules/home-manager.nix (args // {inherit inputs lib pkgs;});

          darwinConfiguration = inputs.nix-darwin.lib.darwinSystem {
            inherit pkgs;
            specialArgs = {
              inherit enableHomeManager;
            };
            modules =
              [
                {
                  # Set Git commit hash for darwin-version.
                  system.configurationRevision = self.rev or self.dirtyRev or null;
                  users.users.${username}.home = homeDirectory;
                  nix.settings.trusted-users = [username];
                }
                ../nix-darwin
                configurationModule
              ]
              ++ lib.optionals (builtins.pathExists localDarwinModule) [
                localDarwinModule
              ]
              ++ lib.optionals enableHomeManager [
                inputs.home-manager.darwinModules.home-manager
                {
                  home-manager = {
                    useUserPackages = true;
                    users.${username} = home-manager;
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
