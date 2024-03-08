{my, ...}: {
  programs.nixvim.plugins.nvim-ufo = {
    enable = true;
    providerSelector = "conf.ufo.provider_selector";
  };

  my.programs.nixvim.plugins.which-key.register = with my.lib.nixvim.keymap; [
    {
      opts.prefix = "z";
      mappings = {
        "R" = wk.lua "conf.ufo.open_all_folds" "Open all folds";
        "M" = wk.lua "conf.ufo.close_all_folds" "Close all folds";
      };
    }
  ];
}
