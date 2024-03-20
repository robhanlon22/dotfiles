{pkgs, ...}:
with pkgs; {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      return require("init")({
        wezterm = wezterm,
      })
    '';
  };

  xdg.configFile.wezterm = {
    source = stdenv.mkDerivation {
      name = "wezterm-config";
      version = "current";
      src = ./fnl;

      nativeBuildInputs = [fennel];

      buildPhase = ''
        runHook preBuild

        build_dir="$(mktemp -d)"

        (
          shopt -s globstar

          for fnl in **/*.fnl; do
            outdir="$build_dir/$(dirname "$fnl")"
            mkdir -p "$outdir"
            fennel --correlate --compile "$fnl" \
              >"$outdir/$(basename "$fnl" .fnl).lua"
          done
        )

        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall
        cp -a "$build_dir" "$out"
        runHook postInstall
      '';
    };

    recursive = true;
  };
}
