{
  imports = [
    ./bufferline.nix
    ./cmp.nix
    ./extra.nix
    ./floaterm.nix
    ./hotpot.nix
    ./lsp.nix
    ./lualine.nix
    ./none-ls.nix
    ./paredit.nix
    ./telescope.nix
    ./treesitter.nix
    ./trouble.nix
    ./ufo.nix
    ./which-key.nix
  ];

  programs.nixvim.plugins = {
    auto-session.enable = true;

    baleia.enable = true;

    better-escape = {
      enable = true;
      mapping = ["jk"];
    };

    comment-nvim.enable = true;

    committia.enable = true;

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
