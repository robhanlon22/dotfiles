{
  pkgs,
  lib,
  ...
}: {
  imports = [./lsp.nix ./lualine.nix ./none-ls.nix ./nvim-cmp.nix ./treesitter.nix];

  programs.nixvim = with lib.my.config; {
    plugins = enabledAll {
      auto-session = {};

      # barbecue = {};

      # barbar = {autoHide = true;};

      bufferline = {};

      better-escape = {mapping = ["jk"];};

      comment-nvim = {};

      conjure = {};

      copilot-lua = {
        suggestion.enabled = false;
        panel.enabled = false;
      };

      floaterm = {};

      inc-rename = {};

      indent-blankline = {};

      illuminate = {};

      lastplace = {};

      leap = {};

      lspkind = {extraOptions = {symbol_map = {Copilot = "";};};};

      lsp-format = {};

      luasnip = {};

      mini = {
        modules = {
          basics = {
            options.extra_ui = true;
            mappings = {
              windows = true;
              move_with_alt = true;
            };
            autocommands.relnum_in_visual_mode = true;
          };
        };
      };

      nix = {};

      nvim-lightbulb = {};

      nvim-ufo.providerSelector = "conf.ufo.provider_selector";

      rainbow-delimiters = {};

      surround = {};

      telescope = {
        extensions = enabledAll {
          file_browser = {};
          frecency = {};
          fzf-native = {};
          ui-select = {};
          undo = {};
        };
        extraOptions = {
          extensions = with lib.nixvim; {
            frecency.db_safe_mode = true;
            ui-select = [
              (mkRaw "conf.telescope.extensions.ui_select.dropdown")
            ];
            zoxide.mappings.default = {
              action = mkRaw "conf.telescope.extensions.zoxide.action";
              keepinsert = true;
            };
          };
        };
      };

      undotree = {};

      typescript-tools.settings.exposeAsCodeAction = "all";

      trouble = {};

      which-key = {};
    };

    extraPlugins = with pkgs.vimPlugins;
    with pkgs.vimUtils; [
      (buildVimPlugin {
        name = "virt-column-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "lukas-reineke";
          repo = "virt-column.nvim";
          rev = "main";
          sha256 = "7ljjJ7UwN2U1xPCtsYbrKdnz6SGQGbM/HrxPTxNKlwo=";
        };
      })
      (buildVimPlugin {
        name = "nvim-paredit";
        src = pkgs.fetchFromGitHub {
          owner = "julienvincent";
          repo = "nvim-paredit";
          rev = "main";
          sha256 = "dSzHYpYHMhgmThnT6ZEqA+axLXlGZLOy7rkzi2YlAts=";
        };
      })
      (buildVimPlugin {
        name = "nvim-paredit-fennel";
        src = pkgs.fetchFromGitHub {
          owner = "julienvincent";
          repo = "nvim-paredit-fennel";
          rev = "main";
          sha256 = "+lQetMbP/H8cKXcxuPiQtEel5jyRDxCsfjwF+1SPVNg=";
        };
      })
      dressing-nvim
      dracula-nvim
      fuzzy-nvim
      hotpot-nvim
      nvim-lspconfig
      plenary-nvim
      telescope-zoxide
    ];
  };
}
