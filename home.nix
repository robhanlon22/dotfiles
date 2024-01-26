{ pkgs, lib, specialArgs, ... }:

{
  home = {
    inherit (specialArgs) username homeDirectory;
    stateVersion = "23.11"; # Please read the comment before changing.

    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      fd
      gh
      ripgrep
      ruby
      wormhole-william
    ];
  };

  programs.nixvim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>p";
        lua = true;
        action = "open_projects";
        options = { desc = "Switch project"; };
      }
      {
        mode = "n";
        key = "<leader><leader>";
        lua = true;
        action = "open_frecency";
        options = { desc = "Open frecent file"; };
      }
    ];

    clipboard = {
      register = "unnamedplus";
    };

    options = {
      expandtab = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      termguicolors = true;
      laststatus = 3;
      undofile = true;
    };

    colorschemes.dracula = {
      enable = true;
      fullSpecialAttrsSupport = true;
    };

    plugins = {
      better-escape = {
        enable = true;
        mapping = [ "jk" ];
      };

      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          nil_ls.enable = true;
        };
        keymaps = {
          diagnostic = {
            "<leader>e" = {
              action = "open_float";
              desc = "Open diagnostics float";
            };
            "<leader>j" = {
              action = "goto_next";
              desc = "Go to next diagnostic";
            };
            "<leader>k" = {
              action = "goto_prev";
              desc = "Go to previous diagnostic";
            };
            "<leader>q" = {
              action = "setloclist";
              desc = "Add diagnostics to location list";
            };
          };
          lspBuf = {
            "<leader>r" = {
              action = "rename";
              desc = "Rename";
            };
            "<leader>c" = {
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
            action = "cmp_tab";
          };
          "<S-Tab>" = {
            modes = [ "i" "s" ];
            action = "cmp_s_tab";
          };
        };

        mappingPresets = [ "insert" "cmdline" ];

        sources = [
          { name = "buffer"; }
          { name = "cmdline"; }
          { name = "git"; }
          { name = "luasnip"; }
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_document_symbol"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "rg"; }
        ];

        window.completion.border = "rounded";
      };

      project-nvim.enable = true;

      rainbow-delimiters.enable = true;

      telescope = {
        enable = true;
        extensions = {
          file_browser.enable = true;
          frecency.enable = true;
          fzf-native.enable = true;
          project-nvim.enable = true;
          undo.enable = true;
        };
      };

      treesitter = {
        enable = true;
        incrementalSelection.enable = true;
        indent = true;
      };

      which-key.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-lspconfig
      typescript-tools-nvim
    ];

    extraConfigLuaPre = builtins.readFile nvim/extra-config-pre.lua;
    extraConfigLua = builtins.readFile nvim/extra-config.lua;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
