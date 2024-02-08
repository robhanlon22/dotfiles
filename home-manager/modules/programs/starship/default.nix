{
  pkgs,
  lib,
  ...
}:
with lib; let
  flavor = "mocha";
  theme = with builtins;
    pipe {
      owner = "catppuccin";
      repo = "starship";
      rev = "main";
      sha256 = "nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
    } [
      pkgs.fetchFromGitHub
      (s: s + /palettes/${flavor}.toml)
      readFile
      fromTOML
    ];
in {
  programs.starship = my.config.enabled {
    settings =
      {
        format = "$all";
        palette = "catppuccin_${flavor}";
        command_timeout = 50;
      }
      // theme;
  };

  programs.zsh.initExtraFirst = ''
    export STARSHIP_LOG=error
  '';
}
