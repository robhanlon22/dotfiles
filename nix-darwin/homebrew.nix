{
  config,
  pkgs,
  ...
}: let
  brewPath = "${config.homebrew.brewPrefix}/brew";
in {
  system.activationScripts.preUserActivation.text = ''
    echo >&2 "ensuring Homebrew is available..."
    if [ ! -x '${brewPath}' ]; then
      NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';

  programs.zsh = {
    shellInit = ''
      eval "$('${brewPath}' shellenv)"
      typeset -aU path
      path=("$HOME/.nix-profile/bin" "''${path[@]}")
    '';
    interactiveShellInit = ''
      source '${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/brew/brew.plugin.zsh'
    '';
  };

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
