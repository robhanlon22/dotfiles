(fn [_vim]
  (let [telescope-themes (require :telescope.themes)]
    {:telescope {:extensions {:ui_select {:dropdown (telescope-themes.get_dropdown {})}}}}))
