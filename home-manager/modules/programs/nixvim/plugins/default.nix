{
  imports = [
    ./bufferline.nix
    ./cmp.nix
    ./copilot.nix
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
    baleia.enable = true;

    better-escape.enable = true;

    comment.enable = true;

    committia.enable = true;

    conjure.enable = true;

    inc-rename.enable = true;

    illuminate.enable = true;

    lastplace.enable = true;

    leap.enable = true;

    luasnip.enable = true;

    nix.enable = true;

    nvim-autopairs.enable = true;

    rainbow-delimiters.enable = true;

    rustaceanvim.enable = true;

    typescript-tools = {
      enable = true;
      settings.expose_as_code_action = "all";
    };

    trouble.enable = true;

    undotree.enable = true;

    vim-surround.enable = true;

    web-devicons.enable = true;
  };
}
