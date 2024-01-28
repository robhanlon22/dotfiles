{ lib, ... }:

{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    border = "rounded";
    enableLspFormat = true;

    sources = {
      code_actions =
        lib.my.enable [ "eslint_d" "gitsigns" "shellcheck" "statix" ];
      diagnostics = lib.my.enable [ "deadnix" "eslint_d" "luacheck" "statix" ];
      formatting = lib.my.enable [
        "eslint_d"
        "fnlfmt"
        "nixfmt"
        "shfmt"
        "stylua"
        "trim_newlines"
        "trim_whitespace"
      ] // {
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
        };
      };
    };

    sourcesItems =
      [{ __raw = ''require("null-ls").builtins.formatting.cljstyle''; }];
  };
}
