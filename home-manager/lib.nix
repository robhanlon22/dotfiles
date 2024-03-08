{
  config,
  lib,
  ...
}: {
  imports = [../lib.nix];

  config.my.lib = {
    terminal = {
      font.name = "CaskaydiaCove Nerd Font";
    };

    shellIntegrations = {
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    hm = {
      activations = with lib;
        pipe ["writeBoundary"] [
          hm.dag.entryAfter
          const
          mapAttrs
        ];
    };

    nixvim = {
      keymap = let
        mkMod = m: k: "<${m}-${toString k}>";
      in rec {
        leader = "<leader>";

        leader- = k: "${leader}${toString k}";

        alt- = mkMod "A";

        ctrl- = mkMod "C";

        which-key = {
          group = name: attrs:
            {
              inherit name;
            }
            // attrs;

          vim = command: desc: [
            "<cmd>${toString command}<cr>"
            desc
          ];

          lua = fn: desc: [
            (config.nixvim.helpers.mkRaw fn)
            desc
          ];
        };

        wk = which-key;
      };
    };
  };
}
