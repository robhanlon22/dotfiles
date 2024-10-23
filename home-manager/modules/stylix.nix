{
  pkgs,
  config,
  ...
}: {
  stylix = {
    enable = true;
    image = config.lib.stylix.pixel "base01";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts.monospace = {
      name = "CaskaydiaCove Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["CascadiaCode"];};
    };
    targets = {
      kitty.enable = false;
      neovim.enable = false;
      nixvim.enable = false;
    };
  };
}
