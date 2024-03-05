{
  pkgs,
  lib,
  ...
}: {
  imports = [./lsp.nix ./lualine.nix ./none-ls.nix ./nvim-cmp.nix ./treesitter.nix];

  programs.nixvim = {
    plugins = {
      auto-session.enable = true;

      bufferline.enable = true;

      better-escape = {
        enable = true;
        mapping = ["jk"];
      };

      comment-nvim.enable = true;

      conjure.enable = true;

      copilot-lua = {
        enable = true;
        suggestion.enabled = false;
        panel.enabled = false;
      };

      floaterm.enable = true;

      inc-rename.enable = true;

      indent-blankline.enable = true;

      illuminate.enable = true;

      lastplace.enable = true;

      leap.enable = true;

      lspkind = {
        enable = true;
        extraOptions = {symbol_map = {Copilot = "";};};
      };

      lsp-format.enable = true;

      luasnip.enable = true;

      mini = {
        enable = true;
        modules = {
          basics = {
            options.extra_ui = true;
            mappings = {
              windows = true;
              move_with_alt = true;
            };
          };
        };
      };

      nix.enable = true;

      nvim-lightbulb.enable = true;

      nvim-ufo = {
        enable = true;
        providerSelector = "conf.ufo.provider_selector";
      };

      rainbow-delimiters.enable = true;

      surround.enable = true;

      telescope = {
        enable = true;
        extensions = {
          file_browser.enable = true;
          fzf-native.enable = true;
          ui-select.enable = true;
          undo.enable = true;
        };
        extraOptions = {
          extensions = with lib.nixvim; {
            ui-select = [
              (mkRaw "conf.telescope.extensions.ui_select.dropdown")
            ];
          };
        };
      };

      undotree.enable = true;

      typescript-tools = {
        enable = true;
        settings.exposeAsCodeAction = "all";
      };

      trouble.enable = true;

      which-key.enable = true;
    };

    extraPlugins = with pkgs;
      (
        with vimPlugins; [
          dressing-nvim
          dracula-nvim
          fuzzy-nvim
          hotpot-nvim
          nvim-lspconfig
          plenary-nvim
          telescope-zoxide
        ]
      )
      ++ (
        map vimUtils.buildVimPlugin [
          {
            name = "virt-column-nvim";
            src = fetchFromGitHub {
              owner = "lukas-reineke";
              repo = "virt-column.nvim";
              rev = "master";
              sha256 = "7ljjJ7UwN2U1xPCtsYbrKdnz6SGQGbM/HrxPTxNKlwo=";
            };
          }
          {
            name = "nvim-paredit";
            src = pkgs.fetchFromGitHub {
              owner = "julienvincent";
              repo = "nvim-paredit";
              rev = "master";
              sha256 = "dSzHYpYHMhgmThnT6ZEqA+axLXlGZLOy7rkzi2YlAts=";
            };
          }
          {
            name = "nvim-paredit-fennel";
            src = pkgs.fetchFromGitHub {
              owner = "julienvincent";
              repo = "nvim-paredit-fennel";
              rev = "master";
              sha256 = "+lQetMbP/H8cKXcxuPiQtEel5jyRDxCsfjwF+1SPVNg=";
            };
          }
        ]
      );
  };
}
