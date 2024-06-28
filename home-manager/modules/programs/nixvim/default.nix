{pkgs, ...}: {
  imports = [./plugins];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    autoCmd = [
      {
        event = ["InsertEnter"];
        pattern = "*";
        command = "set norelativenumber";
      }
      {
        event = ["InsertLeave"];
        pattern = "*";
        command = "set relativenumber";
      }
    ];

    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };

    clipboard.register = "unnamedplus";

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = true;
        integrations = {
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
    };

    opts = {
      colorcolumn = [80];
      expandtab = true;
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      laststatus = 3;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      title = true;
      titlelen = 0;
      titlestring = "\\ %{substitute(getcwd(),$HOME,'~','')}\ \│\ %t";
      undofile = true;
    };

    extraPackages = with pkgs; [nur.repos.bandithedoge.fennel-language-server];

    extraConfigLuaPre = ''
      require("hotpot").setup({})

      local conf = require("conf")(vim)
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
