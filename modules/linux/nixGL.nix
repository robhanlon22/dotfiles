{ pkgs }:

pkg:

let
  nixGL = import <nixgl> { };
  bins = "${pkg}/bin";
in
pkgs.buildEnv {
  name = "nixGL-${pkg.name}";
  paths =
    [ pkg ] ++
    (map
      (bin: pkgs.hiPrio (
        pkgs.writeShellScriptBin bin ''
          exec -a "$0" "${nixGL.auto.nixGLDefault}/bin/nixGL" "${bins}/${bin}" "$@"
        ''
      ))
      (builtins.attrNames (builtins.readDir bins)));
}
