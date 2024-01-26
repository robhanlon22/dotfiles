(fn []
  (let [telescope (require :telescope)
        telescope-builtin (require :telescope.builtin)
        frecency (fn [opts]
                   (let [f telescope.extensions.frecency.frecency]
                     (f (vim.tbl_deep_extend :force {:workspace :CWD}
                                             (or opts {})))))
        zoxide-action (fn [{:path cwd}]
                        (vim.cmd.cd cwd)
                        (frecency {: cwd}))]
    (telescope.setup {:extensions {:zoxide {:mappings {:default {:action zoxide-action
                                                                 :keepinsert true}}}}})
    (telescope.load_extension :zoxide)
    {:telescope {: frecency
                 :file_browser #(telescope.extensions.file_browser.file_browser)
                 :live_grep #(telescope-builtin.live_grep)
                 :zoxide #(telescope.extensions.zoxide.list)}}))
