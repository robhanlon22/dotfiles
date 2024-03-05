{
  pkgs,
  lib,
  ...
}: rec {
  launchdAgent = name: {
    enable ? true,
    zshProgram ? null,
    debug ? false,
    ...
  } @ args: {
    ${name} = {
      inherit enable;
      config =
        {
          RunAtLoad = true;
          KeepAlive = true;
        }
        // (
          lib.optionalAttrs (zshProgram != null) {
            ProgramArguments = ["${pkgs.zsh}/bin/zsh" "-lc" "exec ${zshProgram}"];
          }
        )
        // (
          lib.optionalAttrs debug {
            Debug = true;
            StandardOutPath = "/tmp/${name}.out";
            StandardErrorPath = "/tmp/${name}.err";
          }
        )
        // (
          builtins.removeAttrs args ["zshProgram" "debug" "enable"]
        );
    };
  };

  launchdAgents = lib.concatMapAttrs launchdAgent;
}
