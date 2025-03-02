{
  my,
  config,
  pkgs,
  lib,
  ...
}: {
  options.my.programs.sketchybar.enable = lib.mkEnableOption "sketchybar";

  config = with pkgs;
    lib.mkIf config.my.programs.sketchybar.enable {
      assertions = [
        {
          assertion = stdenv.isDarwin;
          message = "sketchybar is Darwin-only";
        }
      ];

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
            hash = "sha256-JyEYzgJ/zEr2Lvk/ItJ68YOJcBMd+R5uXd5qqu1dWuE=";
          };
        };
      };
    };
}
