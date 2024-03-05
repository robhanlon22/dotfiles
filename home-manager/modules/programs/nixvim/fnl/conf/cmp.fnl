(fn [vim]
  (let [cmp (require :cmp)
        luasnip (require :luasnip)]
    (fn copilot-setup []
      (vim.api.nvim_set_hl 0 :CmpItemKindCopilot {:fg "#6CC644"}))

    (fn comparators-setup []
      (let [{:global {: sorting}} (require :cmp.config)
            copilot (require :copilot_cmp.comparators)
            comparators (vim.list_extend [copilot.prioritize
                                          (require :cmp_fuzzy_buffer.compare)
                                          (require :cmp_fuzzy_path.compare)]
                                         sorting.comparators)]
        (cmp.setup (vim.tbl_deep_extend :force sorting
                                        {:sorting {: comparators}}))))

    (fn cmdline-setup []
      (let [mapping (cmp.mapping.preset.cmdline)
            sources (cmp.config.sources [{:name :fuzzy_path}]
                                        [{:name :cmdline
                                          :option {:ignore_cmds [:Man "!"]}}])]
        (cmp.setup.cmdline ":" {: mapping : sources})))

    (fn search-setup []
      (let [mapping (cmp.mapping.preset.cmdline)
            sources [{:name :fuzzy_buffer} {:name :nvim_lsp_document_symbol}]]
        (cmp.setup.cmdline ["/" "?"] {: mapping : sources})))

    (fn words-before? []
      (when (not= (vim.api.nvim_buf_get_option 0 :buftype) :prompt)
        (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
          (and (not= col 0) (-> (vim.api.nvim_buf_get_text 0 (- line 1) 0
                                                           (- line 1) col {})
                                (. 1)
                                (: :match "^%s*$")
                                (= nil))))))

    (fn tab [fallback]
      (let [words? (words-before?)]
        (if (and (cmp.visible) words?)
            (cmp.select_next_item {:behavior cmp.SelectBehavior.Select})
            (luasnip.expand_or_jumpable)
            (luasnip.expand_or_jump)
            words?
            (cmp.complete)
            (fallback))))

    (fn s_tab [fallback]
      (if (cmp.visible) (cmp.select_prev_item)
          (luasnip.jumpable -1) (luasnip.jump -1)
          (fallback)))

    (copilot-setup)
    (comparators-setup)
    (cmdline-setup)
    (search-setup)
    {:cmp {: tab : s_tab :cr (cmp.mapping.confirm {:select true})}}))
