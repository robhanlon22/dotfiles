(fn [vim]
  (let [telescope (require :telescope)
        telescope-themes (require :telescope.themes)]
    (fn zoxide-action [{: path}]
      (vim.cmd.tcd path)
      (telescope.extensions.frecency.frecency {:cwd path :workspace :CWD}))

    {:telescope {:extensions {:zoxide {:action zoxide-action}
                              :ui_select {:dropdown (telescope-themes.get_dropdown {})}}}}))
