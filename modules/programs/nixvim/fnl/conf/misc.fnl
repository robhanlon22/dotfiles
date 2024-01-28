(fn dracula-setup []
  (let [dracula (require :dracula)]
    (dracula.setup {:theme :dracula-soft
                    :overrides {:CursorLine {:bg "#434958"}}})
    (dracula.setup {:theme :dracula-soft
                    :lualine_bg_color (-> (dracula.colors)
                                          (. :bg))
                    :overrides {:CursorLine {:bg "#434958"}}})))

(fn []
  (dracula-setup)
  {})
