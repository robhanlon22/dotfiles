{lib, ...}: {
  programs.nixvim.plugins.lsp = with lib.my.config;
    enabled {
      servers = enabledAll {
        bashls = {};
        clojure-lsp = {};
        dockerls = {};
        eslint = {};
        graphql = {};
        html = {};
        java-language-server = {};
        lua-ls = {};
        marksman = {};
        nil_ls = {};
        pyright = {};
        rust-analyzer = {
          installRustc = true;
          installCargo = true;
        };
        taplo = {};
        solargraph = {};
        yamlls = {};
      };
      keymaps = with lib.my.nixvim.keymap; {
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
          gD = {
            action = "references";
            desc = "Go to references";
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
}
