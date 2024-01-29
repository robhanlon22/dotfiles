{
  pkgs,
  lib,
  ...
}: {
  imports = [./keymaps ./plugins];

  programs.nixvim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals = rec {
      mapleader = " ";
      maplocalleader = mapleader;
      sexp_filetypes = "lisp,scheme,clojure,fennel";
    };

    clipboard.register = "unnamedplus";

    options = {
      colorcolumn = [80];
      cursorline = true;
      expandtab = true;
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      laststatus = 3;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      undofile = true;
    };

    colorscheme = "dracula-soft";

    extraPackages = with pkgs; [nur.repos.bandithedoge.fennel-language-server];

    extraConfigLuaPre = builtins.readFile ./pre.lua;
  };

  xdg.configFile = {
    "nvim/fnl" = lib.my.config.enabled {
      source = ./fnl;
      recursive = true;
    };
  };
}
