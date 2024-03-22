{inputs, ...}: {
  perSystem = {
    pkgs,
    lib,
    system,
    ...
  }: {
    options.lib.homeManagerConfiguration = with lib;
    with types;
      mkOption {
        type = functionTo anything;
        readOnly = true;
      };

    config.lib.homeManagerConfiguration = {username, ...} @ args: let
      modules = import ./modules.nix (args // {inherit inputs system pkgs;});
    in {
      homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [modules.nixpkgs modules.home-manager];
      };
    };
  };
}
