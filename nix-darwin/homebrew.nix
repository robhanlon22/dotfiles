{
  config,
  lib,
  ...
}: let
  inherit (config.homebrew) brewPrefix;
in {
  environment.systemPath = lib.mkAfter [brewPrefix];
  system.activationScripts.preUserActivation.text = ''
    echo >&2 "Ensuring Homebrew is available..."
    if [ ! -x "${brewPrefix}/brew" ]; then
      NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';
}
