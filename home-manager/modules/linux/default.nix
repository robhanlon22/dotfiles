{
  pkgs,
  lib,
  ...
}: {
  config = lib.my.modules.ifLinux (with lib.my.config; {
    home.packages = with pkgs; [xsel];

    programs.nixvim.clipboard.providers.xsel.enable = true;

    fonts.fontconfig = enabled {};
  });
}
