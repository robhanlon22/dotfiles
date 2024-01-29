(let [ufo (require :ufo)]
  (fn dracula-setup []
    (let [dracula (require :dracula)]
      (dracula.setup {:theme :dracula-soft
                      :overrides {:CursorLine {:bg "#434958"}}})
      (dracula.setup {:theme :dracula-soft
                      :lualine_bg_color (-> (dracula.colors)
                                            (. :bg))
                      :overrides {:CursorLine {:bg "#434958"}}})))

  (fn virt-column-setup []
    (let [virt-column (require :virt-column)]
      (virt-column.setup {})))

  (fn ufo-setup []
    (ufo.setup {:provider_selector (fn [] [:treesitter :indent])}))

  (fn []
    (virt-column-setup)
    (dracula-setup)
    (ufo-setup)
    {:ufo {:open_all_folds ufo.openAllFolds :close_all_folds ufo.closeAllFolds}}))
