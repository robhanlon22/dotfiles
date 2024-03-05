{
  imports = [
    ./bufferline.nix
    ./extra.nix
    ./floaterm.nix
    ./lsp.nix
    ./lualine.nix
    ./none-ls.nix
    ./paredit.nix
    ./telescope.nix
    ./treesitter.nix
    ./nvim-cmp.nix
    ./ufo.nix
    ./which-key.nix
  ];

  programs.nixvim.plugins = {
    auto-session.enable = true;

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

    inc-rename.enable = true;

    illuminate.enable = true;

    lastplace.enable = true;

    leap.enable = true;

    luasnip.enable = true;

    mini = {
      enable = true;
      modules.basics.options.extra_ui = true;
    };

    nix.enable = true;

    nvim-autopairs.enable = true;

    rainbow-delimiters.enable = true;

    surround.enable = true;

    undotree.enable = true;

    typescript-tools = {
      enable = true;
      settings.exposeAsCodeAction = "all";
    };

    trouble.enable = true;
  };
}
