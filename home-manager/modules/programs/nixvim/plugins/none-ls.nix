{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    border = "rounded";
    enableLspFormat = true;

    sources = {
      code_actions = {
        eslint_d.enable = true;
        gitsigns.enable = true;
        shellcheck.enable = true;
        statix.enable = true;
      };

      diagnostics = {
        deadnix.enable = true;
        eslint_d.enable = true;
        luacheck.enable = true;
        statix.enable = true;
      };

      formatting = {
        alejandra.enable = true;
        eslint_d.enable = true;
        fnlfmt.enable = true;
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
        };
        shfmt.enable = true;
        sqlfluff.enable = true;
        stylua.enable = true;
        trim_newlines.enable = true;
        trim_whitespace.enable = true;
      };
    };
  };
}
