{
  self,
  nix-darwin,
  ...
}: {
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
}
