{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hm = {
      url = "github:robhanlon22/hm/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { hm, ... }:
    let
      conf = {
        system = "SYSTEM";
        modules = [ ./home.nix ];
        username = "USERNAME";
        homeDirectory = "/HOME/DIRECTORY";
      };
    in { homeConfigurations.${conf.username} = hm.mkConfig conf; };
}
