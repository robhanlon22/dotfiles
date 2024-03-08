{
  my,
  pkgs,
  ...
}: {
  programs.nixvim.extraPlugins = [
    pkgs.vimPlugins.hotpot-nvim
  ];

  home.activation = my.hm.activations {
    hotpotCache = ''
      (
        set -x
        rm -rf "$HOME/.cache/nvim/hotpot" || true
      )
    '';
  };
}
