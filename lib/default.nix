{
  pkgs,
  nixvim,
  ...
}:
pkgs.lib.extend (self: _super: let
  args = {
    inherit pkgs;
    lib = self;
  };
in {
  my = {
    trace = v: builtins.trace v v;
    nixvim = import ./nixvim.nix args;
    attrsets = import ./attrsets.nix args;
    config = import ./config.nix args;
    modules = import ./modules.nix args;
  };
  nixvim = nixvim.helpers;
})
