{
  config,
  my,
  lib,
  ...
}: {
  imports = [../my.nix];

  config.my = {
    home.bin = "${config.home.profileDirectory}/bin";

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

    nixvim =
      config.lib.nixvim
      // {
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
              (my.nixvim.mkRaw fn)
              desc
            ];
          };

          wk = which-key;
        };
      };
  };
}
