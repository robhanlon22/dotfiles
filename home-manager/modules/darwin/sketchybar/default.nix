{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) sketchybar sketchybar-app-font;
  inherit (lib.my) modules darwin;
in {
  config = modules.ifDarwin {
    home = {
      packages = [sketchybar sketchybar-app-font];

      activation.sketchybarReload = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ${sketchybar}/bin/sketchybar --reload
      '';
    };

    launchd.agents = darwin.launchdAgents {
      sketchybar = {
        zshProgram = "${sketchybar}/bin/sketchybar";
      };
    };

    xdg.configFile = {
      sketchybar = {
        enable = true;
        source = ./sketchybar;
        recursive = true;
      };
      "sketchybar/plugins/icon_map.sh" = {
        enable = true;
        source = pkgs.fetchurl {
          url = "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v${sketchybar-app-font.version}/icon_map.sh";
          sha256 = "KWWukG9S0RWp534N115eQaaG9wpVUgcTAqAmrEScHmQ=";
        };
      };
    };
  };
}
