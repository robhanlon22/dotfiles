{ lib, ... }:

{
  programs.nixvim.plugins.nvim-cmp = lib.my.config.enabled {
    snippet = { expand = "luasnip"; };

    mapping = {
      "<tab>" = {
        modes = [ "i" "s" ];
        action = "conf.cmp.tab";
      };
      "<s-tab>" = {
        modes = [ "i" "s" ];
        action = "conf.cmp.s_tab";
      };
      "<cr>" = {
        modes = [ "i" "s" ];
        action = "conf.cmp.cr";
      };
    };

    mappingPresets = [ "insert" "cmdline" ];

    sources = [
      { name = "cmdline"; }
      { name = "copilot"; }
      { name = "fuzzy_buffer"; }
      { name = "fuzzy_path"; }
      { name = "git"; }
      { name = "luasnip"; }
      { name = "nvim_lsp"; }
      { name = "nvim_lsp_document_symbol"; }
      { name = "nvim_lsp_signature_help"; }
      { name = "nvim_lua"; }
      { name = "rg"; }
      { name = "zsh"; }
    ];

    window.completion.border = "rounded";
  };
}
