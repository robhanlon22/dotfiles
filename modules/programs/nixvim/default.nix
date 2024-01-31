{
  pkgs,
  lib,
  ...
}:
with lib.my.config; {
  imports = [./keymaps ./plugins];

  programs.nixvim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = ",";
      sexp_filetypes = "lisp,scheme,clojure,fennel";
    };

    clipboard.register = "unnamedplus";

    colorschemes.catppuccin = enabled {
      flavour = "mocha";
      integrations.leap = true;
    };

    options = {
      colorcolumn = [80];
      cursorline = true;
      expandtab = true;
      foldcolumn = "1";
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      laststatus = 3;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      title = true;
      titlelen = 0;
      titlestring = "%t (nvim)";
      undofile = true;
    };

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
