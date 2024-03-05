(fn [vim]
  (fn setup []
    (let [cmp (require :cmp)
          luasnip (require :luasnip)
          luasnip-vscode (require :luasnip.loaders.from_vscode)]
      (fn words-before? []
        (and (not= (vim.api.nvim_buf_get_option 0 :buftype) :prompt)
             (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
               (and (not= col 0) (-> (vim.api.nvim_buf_get_text 0 (- line 1) 0
                                                                (- line 1) col
                                                                {})
                                     (. 1)
                                     (: :match "^%s*$")
                                     (= nil))))))

      (fn tab [fallback]
        (if (cmp.visible) (cmp.select_next_item)
            (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
            (words-before?) (cmp.complete)
            (fallback)))

      (fn s-tab [fallback]
        (if (cmp.visible) (cmp.select_prev_item)
            (luasnip.jumpable (- 1)) (luasnip.jump (- 1))
            (fallback)))

      (fn expand [args]
        (let [luasnip (require :luasnip)]
          (luasnip.lsp_expand args.body)))

      (fn before-lspkind [entry vim-item]
        (set vim-item.kind
             (string.format "%s [%s]" vim-item.kind entry.source.name))
        vim-item)

      (luasnip-vscode.lazy_load)
      (cmp.setup {:mapping {:<Tab> (cmp.mapping tab [:i :s])
                            :<S-Tab> (cmp.mapping s-tab [:i :s])
                            :<C-Space> (cmp.mapping.complete)
                            :<C-b> (cmp.mapping.scroll_docs (- 4))
                            :<C-e> (cmp.mapping.abort)
                            :<C-f> (cmp.mapping.scroll_docs 4)
                            :<CR> (cmp.mapping.confirm {:select true})}
                  : expand
                  :sources (cmp.config.sources [{:name :copilot}
                                                {:name :nvim_lsp}
                                                {:name :nvim_lsp_signature_help}
                                                {:name :nvim_lua}
                                                {:name :luasnip}
                                                {:name :fuzzy_path}]
                                               [{:name :fuzzy_buffer}])
                  :formatting {:format (let [{:cmp_format format} (require :lspkind)]
                                         (format {:mode :symbol_text
                                                  :symbol_map {:Copilot ""}
                                                  :show_labelDetails true
                                                  :before before-lspkind}))}
                  :sorting (let [compare (require :cmp.config.compare)
                                 {:prioritize copilot} (require :copilot_cmp.comparators)]
                             {:comparators [copilot
                                            compare.offset
                                            compare.exact
                                            compare.scopes
                                            compare.score
                                            compare.recently_used
                                            compare.locality
                                            compare.kind
                                            compare.sort_text
                                            compare.length
                                            compare.order]
                              :priority_weight 2})
                  :window {:completion (cmp.config.window.bordered)
                           :documentation (cmp.config.window.bordered)}
                  :experimental {:ghost_text true}})
      (cmp.setup.filetype :gitcommit
                          {:sources (cmp.config.sources [{:name :git}]
                                                        [{:name :buffer}])})
      (cmp.setup.cmdline ["/" "?"]
                         {:mapping (cmp.mapping.preset.cmdline)
                          :sources (cmp.config.sources [{:name :command_history}
                                                        {:name :fuzzy_buffer}])})
      (cmp.setup.cmdline ":"
                         {:mapping (cmp.mapping.preset.cmdline)
                          :formatting {:format (fn [_ vim-item]
                                                 (set vim-item.kind "")
                                                 vim-item)}
                          :sources (cmp.config.sources [{:name :path}]
                                                       [{:name :cmdline}
                                                        {:name :command_history}])})))

  {:cmp {: setup}})
