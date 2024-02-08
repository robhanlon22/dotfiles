{
  self,
  nix-darwin,
  nixpkgs,
  system,
  ...
}: args @ {
  hostname,
  username,
  homeDirectory ? "/Users/${username}",
  ...
}: let
  baseModule = {
    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;
    users.users.${username}.home = homeDirectory;
    nixpkgs.hostPlatform = system;
    nix.settings.trusted-users = [username];
  };
  reqArgs = {modules = [baseModule ./configuration.nix];};
  optArgs = nixpkgs.lib.attrsets.optionalAttrs (args ? pkgs) {inherit (args) pkgs;};
  darwinConfiguration = nix-darwin.lib.darwinSystem (reqArgs // optArgs);
in {
  darwinConfigurations.${hostname} = darwinConfiguration;
  inherit (darwinConfiguration) pkgs;
}
