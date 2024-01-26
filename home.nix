{ pkgs, specialArgs, ... }:

let
  antifennel = pkgs.stdenv.mkDerivation {
    name = "antifennel";
    version = "0.3.0-dev";

    nativeBuildInputs = [ pkgs.luajit ];

    src = pkgs.fetchFromSourcehut {
      owner = "~technomancy";
      repo = "antifennel";
      rev = "0a411ae58f17a3e2792d1528105292cd76070c96";
      sha256 = "iuJVBRhhYl+THtDcQbv3SIe/0BWkwxkAYRO1xdIJIqg=";
    };

    LUA = "${pkgs.luajit}/bin/luajit";
    LUA_PATH = "lang/?.lua;;";
    PREFIX = placeholder "out";
  };
  fennel-language-server = let rev = "59005549ca1191bf2aa364391e6bf2371889b4f8";
  in pkgs.rustPlatform.buildRustPackage {
    name = "fennel-language-server";
    version = rev;

    src = pkgs.fetchFromGitHub {
      owner = "rydesun";
      repo = "fennel-language-server";
      inherit rev;
      sha256 = "pp1+lquYRFZLHvU9ArkdLY/kBsfaHoZ9x8wAbWpApck=";
    };

    cargoSha256 = "B4JV1rgW59FYUuqjPzkFF+/T+4Gpr7o4z7Cmpcszcb8=";
  };
in {
  home = {
    inherit (specialArgs) username homeDirectory;

    stateVersion = "23.11";

    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      antifennel
      fd
      fennel-language-server
      fzf
      gh
      kitty
      nodejs
      ripgrep
      ruby
      wormhole-william
    ];
  };

  xdg.configFile = {
    "stylua/stylua.toml" = {
      enable = true;
      source = ./stylua.toml;
    };

    "nvim/fnl" = {
      enable = true;
      source = nvim/fnl;
      recursive = true;
    };
  };

  programs.nixvim = {
    defaultEditor = true;
    enable = true;
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

      conjure.enable = true;

      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          nil_ls.enable = true;
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

      # rainbow-delimiters.enable = true;

      telescope = {
        enable = true;
        extensions = {
          file_browser.enable = true;
          frecency.enable = true;
          fzf-native.enable = true;
          undo.enable = true;
        };
      };

      treesitter = {
        enable = true;
        grammarPackages = with pkgs.tree-sitter-grammars; [
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
      };

      which-key.enable = true;
    };

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
