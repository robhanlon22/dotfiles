{inputs, ...}: {
  perSystem = {
    system,
    lib,
    ...
  }: {
    options.lib.homeManagerConfiguration = with lib;
    with types;
      mkOption {
        type = functionTo anything;
        readOnly = true;
      };

    config.lib.homeManagerConfiguration = {username, ...} @ args: let
      pkgs = import ./modules/nixpkgs.nix (args // {inherit inputs system;});
      home-manager = import ./modules/home-manager.nix (args // {inherit inputs pkgs;});
    in {
      homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [home-manager];
      };
    };
  };
}
