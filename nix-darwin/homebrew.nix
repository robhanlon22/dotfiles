{
  lib,
  config,
  ...
}: let
  brewBinDir = config.homebrew.brewPrefix;
  brewPrefix = builtins.dirOf brewBinDir;
  brewPath = "${brewBinDir}/brew";
in {
  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "raycast"
      "wine-stable"
      "vlc"
    ];
  };

  system.activationScripts.preActivation.text = ''
    echo >&2 "ensuring Homebrew is available..."
    if [ ! -x '${brewPath}' ]; then
      NONINTERACTIVE=1 sudo -u '${config.system.primaryUser}' bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';

  programs.zsh.interactiveShellInit = lib.mkBefore ''
    export HOMEBREW_PREFIX="${brewPrefix}"
    export HOMEBREW_CELLAR="${brewPrefix}/Cellar"
    export HOMEBREW_REPOSITORY="${brewPrefix}"
    export PATH="${brewPrefix}/bin:${brewPrefix}/sbin:$PATH"
    export INFOPATH="${brewPrefix}/share/info:''${INFOPATH:-}"
    fpath=("${brewPrefix}/share/zsh/site-functions" ''${fpath[@]})
    typeset -aU path fpath
    path=(''${path[@]})
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_ENV_HINTS=1
  '';

  launchd.user.agents.brew-upgrade = {
    script = ''
      '${brewPath}' upgrade --greedy && '${brewPath}' cleanup && '${brewPath}' autoremove
    '';
    serviceConfig.StartCalendarInterval = [
      {
        Hour = 9;
        Minute = 0;
      }
    ];
  };
}
