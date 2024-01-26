(fn copilot-setup []
  (vim.api.nvim_set_hl 0 :CmpItemKindCopilot {:fg "#6CC644"}))

(fn fennel-ls-setup []
  (let [lspconfig (require :lspconfig)
        workspace {:library (vim.api.nvim_list_runtime_paths)}
        opts {:settings {:fennel {:diagnostics {:globals [:vim]} : workspace}}}]
    (lspconfig.fennel_language_server.setup opts)))

(fn typescript-tools-setup []
  (let [typescript-tools (require :typescript-tools)
        tsserver_file_preferences {:importModuleSpecifierPreference :non-relative}
        opts {:expose_as_code_action :all : tsserver_file_preferences}]
    (typescript-tools.setup opts)))

(fn []
  (copilot-setup)
  (fennel-ls-setup)
  (typescript-tools-setup)
  {})
