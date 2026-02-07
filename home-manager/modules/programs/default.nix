{
  hmActivations,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./git.nix
    ./kitty
    ./neovim
    ./ssh.nix
    ./starship
    ./zsh
  ];

  home.activation = hmActivations {
    batCacheReset = let
      bat-cache = "${config.programs.bat.package}/bin/bat cache";
    in ''
      ${bat-cache} --clear
      ${bat-cache} --build
    '';
  };

  programs = {
    bash.enable = true;

    bat = {
      enable = true;
      config.theme = "catppuccin-mocha";
      themes.catppuccin-mocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "main";
          hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = false;
    };

    fish.enable = false;

    gpg.enable = true;

    ripgrep.enable = true;

    ssh.enable = true;

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
