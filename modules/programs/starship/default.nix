{lib, ...}:
with lib.my.config; {
  programs.starship = enabled {
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
