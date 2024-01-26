{ pkgs, ... }:

{
  config = {
    programs.nixvim = {
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
        sexp_filetypes = "lisp,scheme,clojure,fennel";
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader><leader>";
          lua = true;
          action = "conf.telescope.frecency";
          options = { desc = "Frecency"; };
        }
        {
          mode = "n";
          key = "<leader>pp";
          lua = true;
          action = "conf.telescope.zoxide";
          options = { desc = "Zoxide"; };
        }
        {
          mode = "n";
          key = "<leader>fb";
          lua = true;
          action = "conf.telescope.file_browser";
          options = { desc = "File browser"; };
        }
        {
          mode = "n";
          key = "<leader>lg";
          lua = true;
          action = "conf.telescope.live_grep";
          options = { desc = "Live grep"; };
        }
      ];

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

      plugins = {
        better-escape = {
          enable = true;
          mapping = [ "jk" ];
        };

        comment-nvim.enable = true;
        copilot-lua.enable = true;
        conjure.enable = true;

        lsp = {
          enable = true;
          servers = {
            bashls.enable = true;
            nil_ls.enable = true;
            solargraph.enable = true;
          };
          keymaps = {
            diagnostic = {
              "<leader>de" = {
                action = "open_float";
                desc = "Open diagnostics float";
              };
              "<leader>dj" = {
                action = "goto_next";
                desc = "Go to next diagnostic";
              };
              "<leader>dk" = {
                action = "goto_prev";
                desc = "Go to previous diagnostic";
              };
              "<leader>dq" = {
                action = "setloclist";
                desc = "Add diagnostics to location list";
              };
            };
            lspBuf = {
              "<leader>cr" = {
                action = "rename";
                desc = "Rename";
              };
              "<leader>ca" = {
                action = "code_action";
                desc = "Code actions";
              };
              K = {
                action = "hover";
                desc = "Show info";
              };
              gD = {
                action = "references";
                desc = "Go to references";
              };
              gd = {
                action = "definition";
                desc = "Go to definition";
              };
              gi = {
                action = "implementation";
                desc = "Go to implementation";
              };
              gt = {
                action = "type_definition";
                desc = "Go to type definition";
              };
            };
          };
        };

        luasnip.enable = true;

        lsp-format.enable = true;

        nix.enable = true;

        none-ls = {
          enable = true;
          border = "rounded";

          sources = {
            code_actions = {
              eslint_d.enable = true;
              gitsigns.enable = true;
              shellcheck.enable = true;
              statix.enable = true;
            };
            diagnostics = {
              deadnix.enable = true;
              eslint_d.enable = true;
              luacheck.enable = true;
              statix.enable = true;
            };
            formatting = {
              eslint_d.enable = true;
              fnlfmt.enable = true;
              nixfmt.enable = true;
              prettier = {
                enable = true;
                disableTsServerFormatter = true;
              };
              shfmt.enable = true;
              stylua.enable = true;
              trim_newlines.enable = true;
              trim_whitespace.enable = true;
            };
          };
        };

        nvim-cmp = {
          enable = true;
          snippet = { expand = "luasnip"; };

          mapping = {
            "<Tab>" = {
              modes = [ "i" "s" ];
              action = "conf.cmp.tab";
            };
            "<S-Tab>" = {
              modes = [ "i" "s" ];
              action = "conf.cmp.s_tab";
            };
          };

          mappingPresets = [ "insert" "cmdline" ];

          sources = [
            { name = "buffer"; }
            { name = "cmdline"; }
            { name = "copilot-cmp"; }
            { name = "git"; }
            { name = "luasnip"; }
            { name = "nvim_lsp"; }
            { name = "nvim_lsp_document_symbol"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "rg"; }
          ];

          window.completion.border = "rounded";
        };

        surround.enable = true;

        rainbow-delimiters.enable = true;

        telescope = {
          enable = true;
          extensions = {
            file_browser.enable = true;
            frecency.enable = true;
            fzf-native.enable = true;
            undo.enable = true;
          };
        };

        treesitter = let
          grammarPackages =
            with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
              tree-sitter-clojure
              tree-sitter-fennel
              tree-sitter-graphql
              tree-sitter-java
              tree-sitter-json
              tree-sitter-lua
              tree-sitter-nix
              tree-sitter-ruby
              tree-sitter-scss
              tree-sitter-typescript
              tree-sitter-yaml
            ];
        in {
          enable = true;
          inherit grammarPackages;
          ensureInstalled = map ({ language }: language) grammarPackages;
        };

        which-key.enable = true;
      };

      extraPackages = with pkgs; [
        (callPackage ../../packages/fennel-language-server.nix { })
        solargraph
      ];

      extraPlugins = with pkgs.vimPlugins; [
        dracula-nvim
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
  };
}
