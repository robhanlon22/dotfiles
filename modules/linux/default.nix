{ pkgs, ... }:

{
  programs.nvim.clipboard.providers.xsel.enable = true;
  home.packages = with pkgs; [ xsel ];
}
