(let [ufo (require :ufo)]
  (fn dracula-setup []
    (let [dracula (require :dracula)]
      (dracula.setup {:theme :dracula-soft
                      :overrides {:CursorLine {:bg "#434958"}}})
      (dracula.setup {:theme :dracula-soft
                      :lualine_bg_color (-> (dracula.colors)
                                            (. :bg))
                      :overrides {:CursorLine {:bg "#434958"}}})))

  (fn deadcolumn-setup []
    (let [deadcolumn (require :deadcolumn)]
      (deadcolumn.setup {})))

  (fn ufo-setup []
    (ufo.setup {:provider_selector (fn [] [:treesitter :indent])}))

  (fn []
    (deadcolumn-setup)
    (dracula-setup)
    (ufo-setup)
    {:ufo {:open_all_folds ufo.openAllFolds :close_all_folds ufo.closeAllFolds}}))
