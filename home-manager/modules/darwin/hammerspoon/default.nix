{
  my,
  pkgs,
  lib,
  ...
}: let
  hammerspoon = with pkgs; (stdenv.mkDerivation rec {
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
  });

  hammerspoonInit = with pkgs;
    runCommand "hammerspoon-init.lua" {
      fennelLib = "${fennel}/share/lua/${lib.versions.majorMinor fennel.lua.version}/?.lua";
      yabaiPath = "${yabai}/bin/yabai";
    } ''
      substitute "${./init.lua}" "$out" --subst-var fennelLib --subst-var yabaiPath
    '';
in {
  config = lib.mkIf pkgs.stdenv.isDarwin {
    home = {
      packages = [hammerspoon];
      file = {
        ".hammerspoon/init.lua".source = hammerspoonInit;
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
