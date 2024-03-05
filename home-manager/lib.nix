{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../lib.nix];

  my.lib = {
    shellIntegrations = {
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    darwin = {
      launchdAgents = attrs: let
        launchdAgent = name: {
          enable ? true,
          zshProgram ? null,
          debug ? false,
          ...
        } @ args: {
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
      in
        if pkgs.stdenv.isDarwin
        then lib.mapAttrs launchdAgent attrs
        else throw "launchdAgents may only be used on Darwin";
    };

    nixvim = {
      keymap = let
        mkMod = m: k: "<${m}-${toString k}>";
      in rec {
        leader = "<leader>";
        leader- = k: "${leader}${toString k}";
        alt- = mkMod "A";
        ctrl- = mkMod "C";
        wk = {
          group = name: attrs: {inherit name;} // attrs;
          vim = command: desc: ["<cmd>${toString command}<cr>" desc];
          lua = fn: desc: [(config.nixvim.helpers.mkRaw fn) desc];
        };
      };
    };
  };
}
