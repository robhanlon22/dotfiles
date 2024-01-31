{lib, ...}:
with lib.my.config; {
  imports = [./modules];

  home.file.".editorconfig".source = ./.editorconfig;

  xdg.configFile = enabledAll {
    "stylua/stylua.toml".source = ./stylua.toml;
    "nix/nix.conf".source = ./nix.conf;
  };
}
