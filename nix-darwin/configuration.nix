{pkgs, ...}: {
  imports = [./homebrew.nix ./my.nix];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      # Necessary for using flakes on this system.
      experimental-features = "nix-command flakes";
    };
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
    };
  };

  programs.zsh.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  system = {
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
