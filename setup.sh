#!/usr/bin/env bash

set -euxfo pipefail

HOME_MANAGER="$HOME/.config/home-manager"

if [[ -d "$HOME/.config/home-manager" ]]; then
  echo "home-manager appears to already be installed."
  exit 0
fi

if ! /nix/nix-installer self-test; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

nix run home-manager/master -- init

cd "$HOME_MANAGER"

cat >flake.nix <<EOF
{
  description = "Home Manager configuration of $USER";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hm.url = "github:robhanlon22/hm/main";
    # hm.url = "path:/path/to/local/hm";
  };

  outputs = { hm, ... }:
    let
      conf = {
        system = "$(nix eval --expr builtins.currentSystem --raw --impure)";
        modules = [ ./home.nix ];
        username = "$USER";
        homeDirectory = "$HOME";
      };
    in { homeConfigurations.$USER = hm.mkConfig conf; };
}
EOF

cat >home.nix <<EOF
{ pkgs, ... }:

{ }
EOF

nix flake update
home-manager switch
