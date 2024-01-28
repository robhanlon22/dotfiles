{ pkgs, ... }:

{
  imports = [ ./keymaps.nix ./plugins ];

  programs.nixvim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals = rec {
      mapleader = " ";
      maplocalleader = mapleader;
      sexp_filetypes = "lisp,scheme,clojure,fennel";
    };

    clipboard = { register = "unnamedplus"; };

    options = {
      expandtab = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      laststatus = 3;
      undofile = true;
    };

    colorscheme = "dracula-soft";

    extraPackages = with pkgs; [ fennel-language-server solargraph ];

    extraPlugins = with pkgs.vimPlugins; [
      dracula-nvim
      fuzzy-nvim
      hotpot-nvim
      nvim-lspconfig
      plenary-nvim
      telescope-zoxide
      typescript-tools-nvim
      vim-sexp
      vim-sexp-mappings-for-regular-people
    ];

    extraConfigLuaPre = ''
      require("hotpot").setup({})
      local conf = require("conf")()
    '';
  };

  xdg.configFile = {
    "nvim/fnl" = {
      enable = true;
      source = ./fnl;
      recursive = true;
    };
  };
}
