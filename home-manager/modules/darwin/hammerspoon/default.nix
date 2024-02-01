{
  pkgs,
  lib,
  ...
}: {
  config = lib.my.modules.ifDarwin {
    home = {
      packages = [
        (with pkgs; (stdenv.mkDerivation rec {
          name = "Hammerspoon";
          version = "0.9.100";

          src = fetchzip {
            url = "https://github.com/Hammerspoon/hammerspoon/releases/download/${version}/Hammerspoon-${version}.zip";
            sha256 = "Q14NBizKz7LysEFUTjUHCUnVd6+qEYPSgWwrOGeT9Q0=";
          };

          dontConfigure = true;
          dontBuild = true;

          installPhase = ''
            runHook preInstall
            ls

            mkdir -p $out/Applications
            cp -r . $out/Applications/Hammerspoon.app

            runHook postInstall
          '';
        }))
      ];
      file = let
        hs = path: ".hammerspoon${path}";
      in {
        ${hs ""} = {
          source = ./.hammerspoon;
          recursive = true;
        };
        ${hs "/init.lua"}.text = ''
          package.path = package.path .. ";${pkgs.lua54Packages.fennel}/share/lua/5.4/?.lua"
          require("fennel").install().dofile("init.fnl")
        '';
        ${hs "/Spoons/VimMode.spoon"} = {
          source = pkgs.fetchFromGitHub {
            owner = "dbalatero";
            repo = "VimMode.spoon";
            rev = "master";
            sha256 = "zpx2lh/QsmjP97CBsunYwJslFJOb0cr4ng8YemN5F0Y=";
          };
          recursive = true;
        };
      };
    };
  };
}
