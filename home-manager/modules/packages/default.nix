{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
      fd
      fennel
      gh
      git
      jq
      nodejs
      ruby
      wormhole-william
    ]
    ++ (config.my.lib.callPackages [
      ./antifennel.nix
      ./caskaydia-cove-nerd-font.nix
    ] {});
}
