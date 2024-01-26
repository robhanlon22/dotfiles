{ pkgs, ... }:

{
  programs.nixvim.clipboard.providers.xsel.enable = true;
  home.packages = with pkgs; [ xsel ];
}
