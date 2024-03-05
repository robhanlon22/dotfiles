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
    if [ -f "${brewPrefix}/brew" ]; then
      PATH="${brewPrefix}":$PATH brew update
    else
      NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';
}
