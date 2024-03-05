{config, ...}: {
  programs.nixvim.plugins.trouble = {
    enable = true;
  };

  my.programs.nixvim.plugins.which-key.register = with config.my.lib.nixvim.keymap; let
    troubleToggle = s: wk.vim "TroubleToggle ${s}";
  in [
    {
      opts.prefix = "<leader>";
      mappings = {
        t = wk.group "Trouble" {
          t = troubleToggle "" "Toggle";
          w = troubleToggle "lsp_workspace_diagnostics" "LSP workspace diagnostics";
          d = troubleToggle "lsp_document_diagnostics" "LSP document diagnostics";
          q = troubleToggle "quickfix" "Quickfix list";
          l = troubleToggle "loclist" "Location list";
        };
      };
    }
    {
      opts.prefix = "g";
      mappings.r = troubleToggle "lsp_references" "LSP references";
    }
  ];
}
