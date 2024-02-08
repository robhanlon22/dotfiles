{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs;
    [
      coreutils
      fd
      fennel
      gh
      git
      jq
      nodejs
      ruby
      wormhole-william
    ]
    ++ (lib.my.callPackages [
      ./antifennel.nix
      ./caskaydia-cove-nerd-font.nix
    ] {});
}
