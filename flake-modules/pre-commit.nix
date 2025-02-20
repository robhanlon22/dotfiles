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
        statix.enable = true;
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
