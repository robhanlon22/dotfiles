{
  pkgs,
  lib,
  ...
}: let
  flavor = "mocha";
  theme =
    lib.pipe {
      owner = "catppuccin";
      repo = "starship";
      rev = "main";
      sha256 = "nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
    } [
      pkgs.fetchFromGitHub
      (s: "${s}/palettes/${flavor}.toml")
      lib.readFile
      builtins.fromTOML
    ];
in {
  programs.starship =
    lib.my.shellIntegrations
    // {
      enable = true;
      settings =
        theme
        // {
          format = "$all";
          palette = "catppuccin_${flavor}";
          command_timeout = 50;
        };
    };

  programs.zsh.initExtraFirst = ''
    export STARSHIP_LOG=error
  '';
}
