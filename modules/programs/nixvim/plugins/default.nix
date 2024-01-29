{ pkgs, lib, ... }:

{
  imports =
    [ ./lsp.nix ./lualine.nix ./none-ls.nix ./nvim-cmp.nix ./treesitter.nix ];

  programs.nixvim = with lib.my.config; {
    plugins = allEnabled {
      auto-session = { };

      barbar = { autoHide = true; };

      better-escape = { mapping = [ "jk" ]; };

      comment-nvim = { };

      conjure = { };

      cursorline = { };

      copilot-lua = {
        suggestion.enabled = false;
        panel.enabled = false;
      };

      floaterm = { };

      inc-rename = { };

      indent-blankline = { };

      lastplace = { };

      leap = { };

      lspkind = { extraOptions = { symbol_map = { Copilot = ""; }; }; };

      lsp-format = { };

      luasnip = { };

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

      navbuddy = { lsp.autoAttach = true; };

      nix = { };

      notify = { };

      nvim-lightbulb = { };

      nvim-ufo = { };

      rainbow-delimiters = { };

      surround = { };

      telescope = {
        extensions = allEnabled {
          file_browser = { };
          frecency = { };
          fzf-native = { };
          undo = { };
        };
      };

      typescript-tools = { settings = { exposeAsCodeAction = "all"; }; };

      trouble = { };

      which-key = { };
    };

    extraPlugins = with pkgs.vimPlugins; [
      (pkgs.vimUtils.buildVimPlugin {
        name = "deadcolumn-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "Bekaboo";
          repo = "deadcolumn.nvim";
          rev = "b84cdf2fc94c59651ececd5e4d2a0488b38a7a75";
          sha256 = "FMtPYT7llNl6PsLM6AvLxy7bKpYqkLoI7+e+VCc6xx0=";
        };
      })
      dracula-nvim
      fuzzy-nvim
      hotpot-nvim
      nvim-lspconfig
      plenary-nvim
      telescope-zoxide
      vim-sexp
      vim-sexp-mappings-for-regular-people
    ];
  };
}
