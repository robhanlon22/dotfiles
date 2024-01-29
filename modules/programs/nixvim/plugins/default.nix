{
  pkgs,
  lib,
  ...
}: {
  imports = [./lsp.nix ./lualine.nix ./none-ls.nix ./nvim-cmp.nix ./treesitter.nix];

  programs.nixvim = with lib.my.config; {
    plugins = enabledAll {
      auto-session = {};

      barbar = {autoHide = true;};

      better-escape = {mapping = ["jk"];};

      comment-nvim = {};

      conjure = {};

      cursorline = {};

      copilot-lua = {
        suggestion.enabled = false;
        panel.enabled = false;
      };

      floaterm = {};

      inc-rename = {};

      indent-blankline = {};

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

      navbuddy = {lsp.autoAttach = true;};

      nix = {};

      nvim-lightbulb = {};

      nvim-ufo = {};

      rainbow-delimiters = {};

      surround = {};

      telescope.extensions = enabledAll {
        file_browser = {};
        frecency = {};
        fzf-native = {};
        undo = {};
      };

      typescript-tools = {settings = {exposeAsCodeAction = "all";};};

      trouble = {};

      which-key = {};
    };

    extraPlugins = with pkgs.vimPlugins; [
      (pkgs.vimUtils.buildVimPlugin {
        name = "virt-column-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "lukas-reineke";
          repo = "virt-column.nvim";
          rev = "refs/tags/v2.0.2";
          sha256 = "7ljjJ7UwN2U1xPCtsYbrKdnz6SGQGbM/HrxPTxNKlwo=";
        };
      })
      dracula-nvim
      fuzzy-nvim
      hotpot-nvim
      nvim-lspconfig
      plenary-nvim
      telescope-ui-select-nvim
      telescope-zoxide
      vim-sexp
      vim-sexp-mappings-for-regular-people
    ];
  };
}
