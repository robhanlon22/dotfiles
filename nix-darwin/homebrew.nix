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

  programs.zsh.shellInit = builtins.readFile (
    pkgs.runCommand "zshenv" {inherit brewPath;} ''
      substitute "${./zshenv}" "$out" --subst-var brewPath
    ''
  );

  launchd.user.agents.brew-upgrade = {
    script = ''
      '${brewPath}' upgrade --greedy && '${brewPath}' cleanup
    '';
    serviceConfig.StartCalendarInterval = [
      {
        Hour = 0;
        Minute = 0;
      }
    ];
  };
}
