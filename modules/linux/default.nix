{ pkgs, ... }:

{
  home.packages = with pkgs; [ xsel ];

  programs.nixvim.clipboard.providers.xsel.enable = true;

  fonts.fontconfig.enable = true;
}
