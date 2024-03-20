{
  my,
  pkgs,
  lib,
  ...
}:
with pkgs; let
  hammerspoon = stdenv.mkDerivation rec {
    name = "Hammerspoon";
    version = "0.9.100";

    src = fetchzip {
      url = "https://github.com/Hammerspoon/hammerspoon/releases/download/${version}/Hammerspoon-${version}.zip";
      hash = "sha256-Q14NBizKz7LysEFUTjUHCUnVd6+qEYPSgWwrOGeT9Q0=";
    };

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      share="$out/share"
      bin="$out/bin"
      man1="$out/share/man/man1"

      mkdir -p "$share" "$bin" "$man1"

      app="$share/Hammerspoon.app"
      cp -a . "$app"

      contents="$app/Contents"
      ln -s "$contents/Frameworks/hs/hs" "$bin"
      gzip < "$contents/Resources/man/hs.man" > "$man1/hs.1.gz"

      runHook postInstall
    '';
  };
in {
  config = lib.mkIf stdenv.isDarwin {
    home = {
      packages = [
        hammerspoon
      ];

      file = {
        ".hammerspoon/init.lua".text = ''
          package.path = package.path .. ";${fennel}/share/lua/${lib.versions.majorMinor fennel.lua.version}/?.lua"

          local fennel = require("fennel")

          debug.traceback = fennel.traceback

          fennel.install()

          require("fnl.init")({
            hs = hs,
            paths = { yabai = "${yabai}/bin/yabai" },
          })
        '';

        ".hammerspoon/fnl" = {
          source = ./fnl;
          recursive = true;
        };
      };

      activation.hammerspoonReload = lib.hm.dag.entryAfter ["writeBoundary"] ''
        "${hammerspoon}/bin/hs" -c 'hs.reload()'
      '';
    };

    launchd = {
      enable = true;
      agents = my.darwin.launchdAgents {
        hammerspoon = {
          debug = true;
          Program = "${hammerspoon}/share/Hammerspoon.app/Contents/MacOS/Hammerspoon";
        };
      };
    };
  };
}
