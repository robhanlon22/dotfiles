(fn base-setup [{: vim : cmp}]
  (let [luasnip (require :luasnip)]
    (fn words-before? []
      (and (not= (vim.api.nvim_buf_get_option 0 :buftype) :prompt)
           (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
             (and (not= col 0) (-> (vim.api.nvim_buf_get_text 0 (- line 1) 0
                                                              (- line 1) col {})
                                   (. 1)
                                   (: :match "^%s*$")
                                   (= nil))))))

    (fn before-lspkind [entry vim-item]
      (set vim-item.kind
           (string.format "%s [%s]" vim-item.kind entry.source.name))
      vim-item)

    (fn next [fallback]
      (if (cmp.visible) (cmp.select_next_item)
          (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
          (words-before?) (cmp.complete)
          (fallback)))

    (fn previous [fallback]
      (if (cmp.visible) (cmp.select_prev_item)
          (luasnip.jumpable (- 1)) (luasnip.jump (- 1))
          (fallback)))

    (fn expand [args]
      (luasnip.lsp_expand args.body))

    (let [next-mapping (cmp.mapping next [:i :s])
          previous-mapping (cmp.mapping previous [:i :s])
          confirm-mapping (cmp.mapping.confirm {:select true})
          mapping {:<Tab> next-mapping
                   :<Down> next-mapping
                   :<S-Tab> previous-mapping
                   :<Up> previous-mapping
                   :<C-Space> (cmp.mapping.complete)
                   :<C-b> (cmp.mapping.scroll_docs (- 4))
                   :<C-e> (cmp.mapping.abort)
                   :<C-f> (cmp.mapping.scroll_docs 4)
                   :<CR> confirm-mapping
                   :<Right> confirm-mapping}
          sources (cmp.config.sources [{:name :nvim_lsp}
                                       {:name :nvim_lsp_signature_help}
                                       {:name :nvim_lua}
                                       {:name :luasnip}
                                       {:name :fuzzy_path}]
                                      [{:name :fuzzy_buffer}])
          formatting {:format (let [{:cmp_format format} (require :lspkind)]
                                (format {:mode :symbol_text
                                         :show_labelDetails true
                                         :before before-lspkind}))}
          compare (require :cmp.config.compare)
          sorting {:comparators [compare.offset
                                 compare.exact
                                 compare.scopes
                                 compare.score
                                 compare.recently_used
                                 compare.locality
                                 compare.kind
                                 compare.sort_text
                                 compare.length
                                 compare.order]
                   :priority_weight 2}
          window {:completion (cmp.config.window.bordered)
                  :documentation (cmp.config.window.bordered)}
          experimental {:ghost_text true}
          performance {:debounce 200 :throttle 100 :max_view_entries 50}]
      (cmp.setup {: mapping
                  : expand
                  : sources
                  : formatting
                  : sorting
                  : window
                  : experimental
                  : performance}))))

(fn gitcommit-setup [{: cmp}]
  (cmp.setup.filetype :gitcommit
                      {:sources (cmp.config.sources [{:name :git}]
                                                    [{:name :buffer}])}))

(fn search-setup [{: cmp}]
  (cmp.setup.cmdline ["/" "?"]
                     {:mapping (cmp.mapping.preset.cmdline)
                      :sources (cmp.config.sources [{:name :command_history}
                                                    {:name :fuzzy_buffer}])}))

(fn cmdline-setup [{: cmp}]
  (cmp.setup.cmdline ":"
                     {:mapping (cmp.mapping.preset.cmdline)
                      :formatting {:format (fn [_ vim-item]
                                             (set vim-item.kind "")
                                             vim-item)}
                      :sources (cmp.config.sources [{:name :path}]
                                                   [{:name :cmdline}
                                                    {:name :command_history}])}))

(local setup-fns [base-setup gitcommit-setup search-setup cmdline-setup])

(fn [vim]
  (fn setup []
    (let [options {: vim :cmp (require :cmp)}]
      (each [_ f (ipairs setup-fns)]
        (f options))))

  (fn capabilities [caps]
    (let [cmp-nvim-lsp (require :cmp_nvim_lsp)]
      (vim.tbl_deep_extend :force caps (cmp-nvim-lsp.default_capabilities))))

  {:cmp {: setup : capabilities}})
