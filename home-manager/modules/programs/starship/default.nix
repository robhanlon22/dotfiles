{
  config,
  pkgs,
  lib,
  ...
}: let
  flavor = "mocha";
  readTOML = path:
    lib.pipe path [
      toString
      builtins.readFile
      builtins.fromTOML
    ];
  catppuccin = readTOML (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/starship/main/palettes/mocha.toml";
    hash = "sha256-cSaZrSfbk97d2kV3q5dT924MgmUuY8eYIIU0PIygH5w=";
  });
  nerdfonts = readTOML (pkgs.runCommand "starship-nerdfonts" {} ''
    ${config.programs.starship.package}/bin/starship preset nerd-font-symbols -o $out
  '');
  settings = {
    format = lib.mkDefault "$all";
    palette = "catppuccin_${flavor}";
    command_timeout = 50;
    directory = nerdfonts.directory // {style = "bold teal";};
    git_branch = nerdfonts.git_branch // {style = "bold lavender";};
    shell = {
      disabled = false;
      bash_indicator = "󰣪";
      nu_indicator = "󰎔";
      zsh_indicator = "󰰷";
    };
  };
  starship = {
    enable = true;
    settings = catppuccin // nerdfonts // settings;
  };
in {
  programs.starship = config.my.lib.shellIntegrations // starship;

  programs.zsh.initExtraFirst = ''
    export STARSHIP_LOG=error
  '';
}
