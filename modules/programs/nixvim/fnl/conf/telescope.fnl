(let [telescope (require :telescope)
      telescope-themes (require :telescope.themes)]
  (fn zoxide-action [{: path}]
    (vim.cmd.cd path)
    (telescope.extensions.frecency.frecency {:cwd path :workspace :CWD}))

  (fn []
    {:telescope {:extensions {:zoxide {:action zoxide-action}
                              :ui_select {:dropdown (telescope-themes.get_dropdown {})}}}}))
