{
  config,
  my,
  lib,
  ...
}: {
  imports = [../my.nix];

  config.my = {
    home.bin = "${config.home.profileDirectory}/bin";

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
      inherit (config.lib.nixvim) toLuaObject mkRaw;

      keymap = let
        mkMod = m: k: "<${m}-${toString k}>";
      in rec {
        leader = "<leader>";

        leader- = k: "${leader}${toString k}";

        alt- = mkMod "A";

        ctrl- = mkMod "C";

        which-key = {
          group = group: mappings: {
            type = "group";
            inherit group mappings;
          };

          vim = action: desc: {
            inherit action desc;
            type = "vim";
          };

          lua = action: desc: {
            inherit action desc;
            type = "lua";
          };

          generic = action: desc: {
            inherit action desc;
            type = "generic";
          };
        };

        wk = which-key;
      };
    };
  };
}
