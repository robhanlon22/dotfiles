(fn fennel-ls-setup []
  (let [lspconfig (require :lspconfig)
        workspace {:library (vim.api.nvim_list_runtime_paths)}
        opts {:settings {:fennel {:diagnostics {:globals [:vim]} : workspace}}}]
    (lspconfig.fennel_language_server.setup opts)))

(fn []
  (fennel-ls-setup)
  {})
