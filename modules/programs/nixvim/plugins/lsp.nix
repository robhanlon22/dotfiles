{ lib, ... }:

{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = lib.my.enable [
      "bashls"
      "clojure-lsp"
      "dockerls"
      "eslint"
      "graphql"
      "html"
      "java-language-server"
      "lua-ls"
      "marksman"
      "nil_ls"
      "pyright"
      "taplo"
      "solargraph"
      "yamlls"
    ] // {
      rust-analyzer = {
        enable = true;
        installRustc = true;
        installCargo = true;
      };
    };
    keymaps = with lib.my.nixvim.keymap; {
      diagnostic = {
        ${leader "do"} = {
          action = "open_float";
          desc = "Open diagnostics float";
        };
        ${leader "dj"} = {
          action = "goto_next";
          desc = "Go to next diagnostic";
        };
        ${leader "dk"} = {
          action = "goto_prev";
          desc = "Go to previous diagnostic";
        };
        ${leader "dq"} = {
          action = "setloclist";
          desc = "Add diagnostics to location list";
        };
      };
      lspBuf = {
        ${leader "cr"} = {
          action = "rename";
          desc = "Rename";
        };
        ${leader "ca"} = {
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
