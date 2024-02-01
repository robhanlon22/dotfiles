{
  self,
  nix-darwin,
  ...
}: {
  system ? "aarch64-darwin",
  hostname,
  username,
  homeDirectory ? "/Users/${username}",
}: let
  base = {
    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;
    users.users.${username}.home = homeDirectory;
    nixpkgs.hostPlatform = system;
  };
in {
  ${hostname} = nix-darwin.lib.darwinSystem {
    modules = [base ./configuration.nix];
  };
}
