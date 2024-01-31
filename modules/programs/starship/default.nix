{
  pkgs,
  lib,
  ...
}:
with lib; let
  flavor = "mocha";
  theme =
    pipe {
      owner = "catppuccin";
      repo = "starship";
      rev = "main";
      sha256 = "nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
    } (with builtins; [
      pkgs.fetchFromGitHub
      (s: s + /palettes/${flavor}.toml)
      readFile
      fromTOML
    ]);
in {
  programs.starship = my.config.enabled {
    settings =
      {
        format = "$all";
        palette = "catppuccin_${flavor}";
      }
      // theme;
  };
}
