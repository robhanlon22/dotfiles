{config, ...}: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        clojure-lsp.enable = true;
        dockerls.enable = true;
        eslint.enable = true;
        graphql.enable = true;
        html.enable = true;
        java-language-server.enable = true;
        lua-ls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        pyright.enable = true;
        rust-analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
        taplo.enable = true;
        solargraph.enable = true;
        yamlls.enable = true;
      };

      keymaps = with config.my.lib.nixvim.keymap; {
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

    lspsaga = {
      enable = true;
      beacon.enable = true;
      lightbulb.enable = true;
    };

    lsp-format.enable = true;
  };

  my.programs.nixvim.plugins.which-key.register = with config.my.lib.nixvim.keymap; [
    {
      opts.prefix = leader;
      mappings.c = wk.group "LSP" {};
    }
  ];
}
