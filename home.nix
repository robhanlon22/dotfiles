_:

{
  imports = [ ./modules ];

  home.file.".editorconfig".source = ./editorconfig;

  xdg.configFile = {
    "stylua/stylua.toml" = {
      enable = true;
      source = ./stylua.toml;
    };
    "nix/nix.conf" = {
      enable = true;
      source = ./nix.conf;
    };
  };
}
