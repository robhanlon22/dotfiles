{
  lib,
  pkgs,
  ...
}: let
  baseConfig = ''
    # Managed by Home Manager.
    config-file = /etc/ghostty/base.conf
    config-file = ?local.conf
  '';
in {
  config = lib.mkIf pkgs.stdenv.isDarwin {
    xdg.configFile."ghostty/config" = {
      force = true;
      text = baseConfig;
    };
  };
}
