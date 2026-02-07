{pkgs, ...}: {
  imports = [
    ./zsh.nix
    ./homebrew.nix
    ./ghostty.nix
    ./my.nix
  ];

  nix = {
    enable = false;
    package = pkgs.nix;
  };

  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableGlobalCompInit = false;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

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
}
