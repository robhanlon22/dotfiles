(let [telescope (require :telescope)]
  (fn zoxide-action [{: path}]
    (vim.cmd.cd path)
    (telescope.extensions.frecency.frecency {:cwd path :workspace :CWD}))

  (fn ui-select-setup []
    (let [telescope-themes (require :telescope.themes)]
      (telescope.setup {:extensions {:ui-select (telescope-themes.get_dropdown {})}})
      (telescope.load_extension :ui-select)))

  (fn zoxide-setup []
    (let [opts {:extensions {:zoxide {:mappings {:default {:action zoxide-action
                                                           :keepinsert true}}}}}]
      (telescope.setup opts)
      (telescope.load_extension :zoxide)))

  (fn []
    (ui-select-setup)
    (zoxide-setup)
    {}))
