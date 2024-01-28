(let [telescope (require :telescope)
      telescope-builtin (require :telescope.builtin)]
  (fn frecency [opts]
    (let [the-opts (vim.tbl_deep_extend :force {:workspace :CWD} (or opts {}))]
      (telescope.extensions.frecency.frecency the-opts)))

  (fn zoxide-action [{:path cwd}]
    (vim.cmd.cd cwd)
    (frecency {: cwd}))

  (fn zoxide-setup []
    (let [opts {:extensions {:zoxide {:mappings {:default {:action zoxide-action
                                                           :keepinsert true}}}}}]
      (telescope.setup opts)
      (telescope.load_extension :zoxide)))

  (fn []
    (zoxide-setup)
    {:telescope {: frecency
                 :file_browser telescope.extensions.file_browser.file_browser
                 :live_grep telescope-builtin.live_grep
                 :zoxide telescope.extensions.zoxide.list}}))
