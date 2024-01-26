(fn []
  (let [cmp (require :cmp)
        luasnip (require :luasnip)
        words-before? (fn []
                        (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
                          (and (not= col 0)
                               (= (-> (vim.api.nvim_buf_get_lines 0 (- line 1)
                                                                  line true)
                                      (. 1)
                                      (: :sub col col)
                                      (: :match "%s"))
                                  nil))))]
    (cmp.setup.cmdline ":"
                       {:mapping (cmp.mapping.preset.cmdline)
                        :sources (cmp.config.sources [{:name :path}]
                                                     [{:name :cmdline
                                                       :option {:ignore_cmds [:Man
                                                                              "!"]}}])})
    (cmp.setup.cmdline ["/" "?"]
                       {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name :nvim_lsp_document_symbol}
                                  {:name :buffer}]})
    {:cmp {:tab (fn [fallback]
                  (if (cmp.visible) (cmp.select_next_item)
                      (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
                      (words-before?) (cmp.complete)
                      (fallback)))
           :s_tab (fn [fallback]
                    (if (cmp.visible) (cmp.select_prev_item)
                        (luasnip.jumpable (- 1)) (luasnip.jump (- 1))
                        (fallback)))}}))
