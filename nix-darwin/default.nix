{
  nix-darwin,
  nixpkgs,
  self,
  system,
  ...
}: {
  homeDirectory ? "/Users/${username}",
  hostname,
  username,
  modules ? [],
  ...
} @ args: let
  baseModule = {
    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;
    users.users.${username}.home = homeDirectory;
    nixpkgs.hostPlatform = system;
    nix.settings.trusted-users = [username];
  };

  required = {
    modules =
      [
        baseModule
        ./configuration.nix
      ]
      ++ modules;
  };

  optional = nixpkgs.lib.attrsets.optionalAttrs (args ? pkgs) {
    inherit (args) pkgs;
  };

  darwinConfiguration = nix-darwin.lib.darwinSystem (required // optional);
in {
  darwinConfigurations.${hostname} = darwinConfiguration;
  inherit (darwinConfiguration) pkgs;
}
