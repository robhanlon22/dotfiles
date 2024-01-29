{ lib, ... }:

{
  programs.nixvim.plugins.none-ls = with lib.my.config;
    enabled {
      border = "rounded";
      enableLspFormat = true;

      sources = {
        code_actions = allEnabled {
          eslint_d = { };
          gitsigns = { };
          shellcheck = { };
          statix = { };
        };

        diagnostics = allEnabled {
          deadnix = { };
          eslint_d = { };
          luacheck = { };
          statix = { };
        };

        formatting = allEnabled {
          eslint_d = { };
          fnlfmt = { };
          nixfmt = { };
          prettier = { disableTsServerFormatter = true; };
          shfmt = { };
          stylua = { };
          trim_newlines = { };
          trim_whitespace = { };
        };
      };

      sourcesItems =
        [{ __raw = ''require("null-ls").builtins.formatting.cljstyle''; }];
    };
}
