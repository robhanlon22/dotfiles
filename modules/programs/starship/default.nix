{
  pkgs,
  lib,
  ...
}:
with lib.my.config; {
  programs.starship = let
    flavour = "mocha";
  in
    enabled {
      settings =
        {
          format = "$all";
          palette = "catppuccin_${flavour}";
        }
        // builtins.fromTOML (builtins.readFile
          (pkgs.fetchFromGitHub
            {
              owner = "catppuccin";
              repo = "starship";
              rev = "main";
              sha256 = "nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
            }
            + /palettes/${flavour}.toml));
    };
}
