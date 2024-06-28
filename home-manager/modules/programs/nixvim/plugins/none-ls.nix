{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    settings.border = "rounded";

    sources = {
      code_actions = {
        statix.enable = true;
      };

      diagnostics = {
        deadnix.enable = true;
        statix.enable = true;
      };

      formatting = {
        alejandra.enable = true;
        fnlfmt.enable = true;
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
        };
        shfmt.enable = true;
        sqlfluff.enable = true;
        stylua.enable = true;
      };
    };
  };
}
