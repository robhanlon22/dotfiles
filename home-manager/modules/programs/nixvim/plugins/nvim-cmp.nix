{
  programs.nixvim = {
    plugins = {
      cmp-buffer.enable = true;
      cmp-cmdline-history.enable = true;
      cmp-cmdline.enable = true;
      cmp-fuzzy-buffer.enable = true;
      cmp-fuzzy-path.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-nvim-lsp.enable = true;
      copilot-cmp.enable = true;
      friendly-snippets.enable = true;
      lsp.capabilities = ''
        capabilities = vim.tbl_deep_extend("force", capabilities, require('cmp_nvim_lsp').default_capabilities())
      '';
      lspkind.enable = true;
      luasnip.enable = true;
      nvim-cmp.enable = true;
    };
    extraConfigLuaPost = ''
      conf.cmp.setup()
    '';
  };
}
