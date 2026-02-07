{nixvimKeymap, ...}: {
  programs.nixvim.plugins.trouble = {
    enable = true;
  };

  my.programs.nixvim.plugins.which-key.register = with nixvimKeymap; let
    troubleCmd = mode: opts: wk.vim "Trouble ${mode} ${opts}";
    troubleToggle = mode: troubleCmd mode "toggle";
    troubleFocus = mode: troubleCmd mode "toggle focus=false";
  in [
    {
      opts.prefix = "<leader>";
      mappings = {
        x = wk.group "Trouble" {
          x = troubleToggle "diagnostics" "Toggle diagnostics";
          X = troubleCmd "diagnostics" "toggle filter.buf=0" "Buffer diagnostics";
          s = troubleFocus "symbols" "Toggle symbols outline";
          l = troubleToggle "lsp" "Toggle LSP references/definitions";
          L = troubleToggle "loclist" "Toggle location list";
          Q = troubleToggle "qflist" "Toggle quickfix list";
        };
      };
    }
    {
      opts.prefix = "g";
      mappings = {
        r = troubleToggle "lsp_references" "LSP references";
        d = troubleToggle "lsp_definitions" "LSP definitions";
        D = troubleToggle "lsp_type_definitions" "LSP type definitions";
        I = troubleToggle "lsp_implementations" "LSP implementations";
      };
    }
    {
      opts.prefix = "]";
      mappings.x = wk.vim "lua require('trouble').next({skip_groups = true, jump = true})" "Next trouble item";
    }
    {
      opts.prefix = "[";
      mappings.x = wk.vim "lua require('trouble').prev({skip_groups = true, jump = true})" "Previous trouble item";
    }
  ];
}
