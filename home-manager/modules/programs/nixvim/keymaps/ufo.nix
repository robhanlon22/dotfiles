{config, ...}: {
  programs.nixvim.plugins.which-key.registrations = with config.my.lib.nixvim.keymap; {
    "zR" = wk.lua "conf.ufo.open_all_folds" "Open all folds";
    "zM" = wk.lua "conf.ufo.close_all_folds" "Close all folds";
  };
}
