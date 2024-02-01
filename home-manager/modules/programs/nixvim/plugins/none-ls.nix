{lib, ...}: {
  programs.nixvim.plugins.none-ls = with lib.my.config;
    enabled {
      border = "rounded";
      enableLspFormat = true;

      sources = {
        code_actions = enabledAll {
          eslint_d = {};
          gitsigns = {};
          shellcheck = {};
          statix = {};
        };

        diagnostics = enabledAll {
          deadnix = {};
          eslint_d = {};
          luacheck = {};
          statix = {};
        };

        formatting = enabledAll {
          alejandra = {};
          eslint_d = {};
          fnlfmt = {};
          prettier = {disableTsServerFormatter = true;};
          shfmt = {};
          stylua = {};
          trim_newlines = {};
          trim_whitespace = {};
        };
      };

      sourcesItems = [{__raw = ''require("null-ls").builtins.formatting.cljstyle'';}];
    };
}
