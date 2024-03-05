(fn [vim]
  (fn fennel-ls-setup []
    (let [lspconfig (require :lspconfig)
          workspace {:library (vim.api.nvim_list_runtime_paths)}
          opts {:settings {:fennel {: workspace}}}]
      (lspconfig.fennel_language_server.setup opts)))

  (fennel-ls-setup)
  {})
