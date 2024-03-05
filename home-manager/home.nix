{
  imports = [./modules];

  home.file.".editorconfig".source = ../.editorconfig;

  xdg.configFile."stylua/stylua.toml" = {
    enable = true;
    source = ./stylua.toml;
  };

  programs.home-manager.enable = true;
}
