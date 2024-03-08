{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf pkgs.stdenv.isDarwin {
    my.lib = {
      terminal.font.size = 15;

      darwin = {
        launchdAgents = lib.mapAttrs (name: {
            enable ? true,
            zshProgram ? null,
            debug ? false,
            ...
          } @ args: let
            baseAttrs = {
              RunAtLoad = true;
              KeepAlive = true;
            };

            zshAttrs = lib.optionalAttrs (zshProgram != null) {
              ProgramArguments = [
                "${config.programs.zsh.package}/bin/zsh"
                "-lc"
                "exec ${zshProgram}"
              ];
            };

            debugAttrs = lib.optionalAttrs debug {
              Debug = true;
              StandardOutPath = "/tmp/${name}.out";
              StandardErrorPath = "/tmp/${name}.err";
            };

            extraAttrs = builtins.removeAttrs args [
              "debug"
              "enable"
              "zshProgram"
            ];
          in {
            inherit enable;
            config = baseAttrs // zshAttrs // debugAttrs // extraAttrs;
          });
      };
    };
  };
}
