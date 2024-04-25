(fn [_vim]
  (fn ui-select-setup []
    (let [telescope (require :telescope)
          telescope-themes (require :telescope.themes)]
      (telescope.setup {:extensions {:ui_select [(telescope-themes.get_dropdown {})]}})))

  (ui-select-setup)
  {})
