{ config, pkgs, lib, ... }:

let
  username = "rob";
  homeDirectory = "/Users/${username}";
in
  {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = username;
    home.homeDirectory = homeDirectory;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')

      pkgs.curlFull
      pkgs.fd

      # LSP
      pkgs.lua-language-server
      pkgs.nil
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
      ".oh-my-zsh/custom/themes/powerlevel10k".source = pkgs.fetchFromGitHub {
        owner = "romkatv";
        repo = "powerlevel10k";
        rev = "refs/tags/v1.19.0";
        sha256 = "+hzjSbbrXr0w1rGHm6m2oZ6pfmD6UUDBfPd7uMg5l5c=";
      };

      ".p10k.zsh".source = etc/zsh/p10k.zsh;
    };

    # You can also manage environment variables but you will have to manually
    # source
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/rob/etc/profile.d/hm-session-vars.sh
    #
    # if you don't want to manage your shell through Home Manager.
    home.sessionVariables = {
      ZSH_CUSTOM = ".oh-my-zsh/custom";
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withRuby = true;
      withPython3 = true;
      withNodeJs = true;
      plugins = with pkgs.vimPlugins; [
        dracula-nvim
        fzf-vim
        fzfWrapper
        nvim-lspconfig
        vim-commentary
        vim-gitgutter
        zoxide-vim
      ];
      extraLuaConfig = builtins.readFile etc/nvim/init.lua;
    };

    programs.ripgrep = {
      enable = true;
      arguments = ["--glob=!Dropbox/**/*"];
    };

    programs.zsh = {
      enable = true;
      initExtra = builtins.readFile etc/zsh/zshrc;
      shellAliases = {
        ls = "ls --color";
        hm = "home-manager";
        hms = "home-manager switch";
        hmb = "home-manager build";
      };
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "ruby" "rust" "python"];
        theme = "powerlevel10k/powerlevel10k";
      };
    };

    programs.zoxide.enable = true;

    programs.rbenv = {
      enable = true;
      plugins = [
        {
          name = "ruby-build";
          src = pkgs.fetchFromGitHub {
            owner = "rbenv";
            repo = "ruby-build";
            rev = "v20230919";
            hash = "sha256-w9RwOqCFn9845MR01KwOz/FELiEYUcftBPbGs3Z/jTc=";
          };
        }
      ];
    };

    programs.kitty = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (pkgs.callPackage ./kitty.nix {});
      shellIntegration.enableZshIntegration = true;
      theme = "Dracula";
      font = {
        name = "CaskaydiaCove Nerd Font Mono";
        size = 14.0;
      };
    };

    programs.fzf = {
      enable = true;
      defaultCommand = "fd --type file --hidden --no-ignore --exclude .git";
    };

    home.activation.aliasApplications = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (
      let
        flakePkg = uri:
          (builtins.getFlake uri).packages.${builtins.currentSystem}.default;
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
        lastAppsFile = "${config.xdg.stateHome}/nix/linked-apps.txt";
        lastApps = if builtins.pathExists lastAppsFile then
                     builtins.readFile lastAppsFile
                   else 
                     "";
        appsPath = "${homeDirectory}/Applications/Nix";
      in
        lib.hm.dag.entryAfter ["writeBoundary"] ''
          next_apps=$(readlink -f "${apps}/Applications/"* | sort)

          if [ "${lastApps}" = "$next_apps" ]; then
            exit
          fi

          echo "Apps have changed. Updating macOS aliases..."

          $DRY_RUN_CMD mkdir -p "${appsPath}"

          $DRY_RUN_CMD "${pkgs.fd}/bin/fd" \
            -t l -d 1 . "${apps}/Applications" \
            -x $DRY_RUN_CMD "${flakePkg "github:reckenrode/mkAlias"}/bin/mkalias" \
            -L {} "${appsPath}/{/}"

          [ -z "$DRY_RUN_CMD" ] && echo "$next_apps" > "${lastAppsFile}"
        ''
    );

    programs.git.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  }
