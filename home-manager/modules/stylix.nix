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
      package = pkgs.nerd-fonts.caskaydia-cove;
    };
    targets = {
      bat.enable = false;
      fish.enable = false;
      kitty.enable = false;
      neovim.enable = false;
      nixvim.enable = false;
      starship.enable = false;
    };
  };
}
