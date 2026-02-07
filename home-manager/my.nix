{
  config,
  lib,
  ...
}: {
  imports = [../my.nix];

  _module.args = {
    homeBin = "${config.home.profileDirectory}/bin";

    hmActivations = with lib;
      pipe
      ["writeBoundary"]
      [
        hm.dag.entryAfter
        const
        mapAttrs
      ];
  };
}
