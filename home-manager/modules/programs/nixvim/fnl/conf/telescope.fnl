(fn [_vim]
  (fn smart-open-setup []
    (let [telescope (require :telescope)]
      (telescope.setup {:extensions {:smart_open {:match_algorithm :fzf}}})
      (telescope.load_extension :smart_open)))

  (smart-open-setup)
  (let [telescope-themes (require :telescope.themes)]
    {:telescope {:extensions {:ui_select {:dropdown (telescope-themes.get_dropdown {})}}}}))
