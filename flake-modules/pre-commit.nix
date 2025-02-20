{
  perSystem = {
    pkgs,
    lib,
    ...
  }:
    with lib; {
      options.lib.preCommitHooks = with types;
        mkOption {
          type = attrs;
          readOnly = true;
        };

      config.lib.preCommitHooks = {
        alejandra.enable = true;
        deadnix.enable = true;
        editorconfig-checker.enable = true;
        fnlfmt = {
          enable = true;
          name = "fnlfmt";
          description = "Run fnlfmt on Fennel files";
          files = "\\.fnl$";
          entry = "${pkgs.fnlfmt}/bin/fnlfmt --fix";
        };
        luacheck.enable = true;
        prettier = {
          enable = true;
          files = "\\.(md|json|yaml|yml)$";
        };
        shellcheck.enable = true;
        shfmt.enable = true;
        statix.enable = true;
        stylua.enable = true;
        taplo.enable = true;

        # ~ is to force git-diff to run last because pre-commit runs hooks in
        # alphabetical order
        "~git-diff" = {
          enable = true;
          name = "git-diff";
          description = "Show git diff when files have been changed";
          entry = "${pkgs.git}/bin/git diff --color --exit-code";
          always_run = true;
          pass_filenames = false;
          require_serial = true;
        };
      };
    };
}
