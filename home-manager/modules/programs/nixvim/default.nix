{pkgs, ...}: {
  imports = [./keymaps ./plugins];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = ",";
      sexp_filetypes = "lisp,scheme,clojure,fennel";
    };

    clipboard.register = "unnamedplus";

    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      transparentBackground = true;
      integrations = {
        cmp = true;
        gitsigns = true;
        illuminate = {
          enabled = true;
          lsp = true;
        };
        indent_blankline.enabled = true;
        leap = true;
        lsp_trouble = true;
        mini.enabled = true;
        native_lsp.enabled = true;
        telescope.enabled = true;
      };
    };

    options = {
      colorcolumn = [80];
      expandtab = true;
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      laststatus = 3;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      title = true;
      titlelen = 0;
      titlestring = "\\ %{substitute(getcwd(),$HOME,'~','')}\ \󰇙\ %t";
      undofile = true;
    };

    extraPackages = with pkgs; [nur.repos.bandithedoge.fennel-language-server];

    extraConfigLuaPre = builtins.readFile ./pre.lua;
  };

  xdg.configFile = {
    "nvim/fnl" = {
      enable = true;
      source = ./fnl;
      recursive = true;
    };
  };
}
