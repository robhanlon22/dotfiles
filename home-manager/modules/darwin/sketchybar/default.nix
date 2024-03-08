{
  my,
  pkgs,
  lib,
  ...
}: {
  config = with pkgs;
    lib.mkIf stdenv.isDarwin {
      home = {
        packages = [sketchybar sketchybar-app-font];

        activation = my.hm.activations {
          sketchybarReload = ''
            ${sketchybar}/bin/sketchybar --reload
          '';
        };
      };

      launchd.agents = my.darwin.launchdAgents {
        sketchybar.zshProgram = "${sketchybar}/bin/sketchybar";
      };

      xdg.configFile = {
        sketchybar = {
          enable = true;
          source = ./sketchybar;
          recursive = true;
        };

        "sketchybar/plugins/icon_map.sh" = {
          enable = true;
          source = fetchurl {
            url = "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v${sketchybar-app-font.version}/icon_map.sh";
            hash = "sha256-KWWukG9S0RWp534N115eQaaG9wpVUgcTAqAmrEScHmQ=";
          };
        };
      };
    };
}
