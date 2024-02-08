{
  pkgs,
  lib,
  ...
}:
with lib.my.config; let
  inherit (pkgs) sketchybar sketchybar-app-font;
in {
  config = lib.my.modules.ifDarwin {
    home = {
      packages = [sketchybar sketchybar-app-font];

      activation.sketchybarReload = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ${sketchybar}/bin/sketchybar --reload
      '';
    };

    launchd = enabled {
      agents = enabledAll {
        sketchybar.config = {
          ProgramArguments = ["${pkgs.zsh}/bin/zsh" "-lc" "exec ${sketchybar}/bin/sketchybar"];
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "/tmp/sketchybar.log";
          StandardErrorPath = "/tmp/sketchybar.err";
        };
      };
    };

    xdg.configFile = enabledAll {
      sketchybar = {
        source = ./sketchybar;
        recursive = true;
      };
      "sketchybar/plugins/icon_map.sh".source = pkgs.fetchurl {
        url = "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v${sketchybar-app-font.version}/icon_map.sh";
        sha256 = "KWWukG9S0RWp534N115eQaaG9wpVUgcTAqAmrEScHmQ=";
      };
    };
  };
}
