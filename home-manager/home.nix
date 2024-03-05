{
  imports = [./modules ./lib.nix];

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        indent_style = "space";
        indent_size = 2;
      };
      "*.lua" = {
        column_width = 80;
        indent_type = "Spaces";
        sort_requires = true;
      };
    };
  };

  programs.home-manager.enable = true;
}
