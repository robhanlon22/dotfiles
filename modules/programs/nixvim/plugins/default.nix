_:

{
  imports =
    [ ./lsp.nix ./treesitter.nix ./nvim-cmp.nix ./none-ls.nix ./lualine.nix ];

  programs.nixvim.plugins = {
    barbar = {
      enable = true;
      autoHide = true;
    };

    better-escape = {
      enable = true;
      mapping = [ "jk" ];
    };

    comment-nvim.enable = true;

    conjure.enable = true;

    copilot-lua = {
      enable = true;
      suggestion.enabled = false;
      panel.enabled = false;
    };

    luasnip.enable = true;

    lsp-format.enable = true;

    lspkind = {
      enable = true;
      extraOptions = { symbol_map = { Copilot = ""; }; };
    };

    nix.enable = true;

    persistence.enable = true;

    startify.enable = true;

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

    which-key.enable = true;
  };
}
