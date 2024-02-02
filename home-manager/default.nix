{
  system,
  nixpkgs,
  nixvim,
  home-manager,
  nur,
  cljstyle,
  nixpkgs-ruby,
  ...
}: args @ {
  hostname,
  username,
  stateVersion ? "23.11",
  modules ? [],
  overlays ? [],
  ...
}: let
  pkgs = args.pkgs or nixpkgs.legacyPackages.${system};

  homeDirectory =
    args.homeDirectory
    or (
      if pkgs.stdenv.isDarwin
      then "/Users/${username}"
      else "/home/${username}"
    );

  lib = nixpkgs.lib.extend (self: _super:
    import ./lib {
      inherit pkgs;
      lib = self;
      nixvim = nixvim.lib.${system};
    });

  baseModule = {
    home = {
      inherit username homeDirectory stateVersion;
    };

    nixpkgs = {
      config.allowUnfree = true;
      overlays =
        [
          nur.overlay
          nixpkgs-ruby.overlays.default
          (_: _: {
            inherit lib;
            cljstyle = cljstyle.packages.${system}.default;
          })
        ]
        ++ overlays;
    };
  };
in {
  homeConfigurations."${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs lib;
    modules =
      [
        baseModule
        nixvim.homeManagerModules.nixvim
        ./home.nix
      ]
      ++ modules;
  };
}
