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

  services = {
    yabai = {
      enable = true;
      config = {
        active_window_opacity = 1.0;
        auto_balance = "off";
        focus_follows_mouse = "off";
        external_bar = "all:44:0";
        insert_feedback_color = "0xffd75f5f";
        layout = "stack";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_drop_action = "swap";
        mouse_follows_focus = "off";
        mouse_modifier = "fn";
        normal_window_opacity = 0.90;
        split_ratio = 0.50;
        split_type = "auto";
        window_animation_duration = 0.0;
        window_animation_frame_rate = 120;
        window_opacity = "off";
        window_opacity_duration = 0.0;
        window_origin_display = "default";
        window_placement = "second_child";
        window_shadow = "on";
        window_zoom_persist = "on";
      };
    };
  };
}
