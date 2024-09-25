{
  pkgs,
  config,
  ...
}: {
  imports = [./modules ./my.nix];
  stylix = {
    enable = true;
    image = config.lib.stylix.pixel "base0A";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts.monospace = {
      name = "CaskaydiaCove Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["CascadiaCode"];};
    };
    targets = {
      kitty.variant256Colors = true;
      neovim.enable = false;
    };
  };
}
