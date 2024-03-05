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
    gc = {
      automatic = true;
      interval = {
        Hour = 0;
        Minute = 0;
      };
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  security.pam.enableSudoTouchIdAuth = true;

  system = {
    # Used for backwards compatibility, please read the changelog before
    # changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;
    defaults = {
      NSGlobalDomain = {
        _HIHideMenuBar = true;
        "com.apple.keyboard.fnState" = true;
        "com.apple.sound.beep.feedback" = 0;
      };
      dock = {
        autohide = true;
        launchanim = false;
        orientation = "right";
        show-recents = false;
        static-only = true;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tr-corner = 1;
        wvous-tl-corner = 1;
      };
      finder = {
        AppleShowAllFiles = false;
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
      };
    };
  };

  nixpkgs.config.allowUnfree = true;
}
