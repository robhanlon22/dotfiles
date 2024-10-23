{my, ...}: {
  programs.nixvim.plugins = {
    conform-nvim = {
      enable = true;
      settings.format_on_save.lsp_format = "fallback";
    };

    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        clojure_lsp.enable = true;
        dockerls.enable = true;
        eslint.enable = true;
        graphql.enable = true;
        html.enable = true;
        java_language_server.enable = true;
        lua_ls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
        taplo.enable = true;
        solargraph.enable = true;
        yamlls.enable = true;
      };

      keymaps = with my.nixvim.keymap; {
        diagnostic = {
          ${leader- "cd"} = {
            action = "open_float";
            desc = "Open diagnostics float";
          };
          ${leader- "cj"} = {
            action = "goto_next";
            desc = "Go to next diagnostic";
          };
          ${leader- "ck"} = {
            action = "goto_prev";
            desc = "Go to previous diagnostic";
          };
          ${leader- "cq"} = {
            action = "setloclist";
            desc = "Add diagnostics to location list";
          };
        };
        lspBuf = {
          ${leader- "cr"} = {
            action = "rename";
            desc = "Rename";
          };
          ${leader- "ca"} = {
            action = "code_action";
            desc = "Code actions";
          };
          K = {
            action = "hover";
            desc = "Show info";
          };
          gd = {
            action = "definition";
            desc = "Go to definition";
          };
          gi = {
            action = "implementation";
            desc = "Go to implementation";
          };
          gt = {
            action = "type_definition";
            desc = "Go to type definition";
          };
        };
      };
    };
  };

  my.programs.nixvim.plugins.which-key.register = with my.nixvim.keymap; [
    {
      opts.prefix = leader;
      mappings.c = wk.group "LSP" {};
    }
  ];
}
