{ pkgs, lib, ... }:

{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    home = { packages = with pkgs; [ raycast ]; };
    programs.zsh.initExtra = builtins.readFile ./zshrc;
  };
}
