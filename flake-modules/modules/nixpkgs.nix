{
  inputs,
  overlays ? [],
  system,
  ...
}:
import inputs.nixpkgs {
  inherit system;
  hostPlatform = system;
  config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  overlays = [inputs.nur.overlays.default] ++ overlays;
}
