{
  hmActivations,
  pkgs,
  ...
}: {
  programs.nixvim.extraPlugins = [
    pkgs.vimPlugins.hotpot-nvim
  ];

  home.activation = hmActivations {
    hotpotCache = ''
      (
        set -x
        rm -rf "$HOME/.cache/nvim/hotpot" || true
      )
    '';
  };
}
