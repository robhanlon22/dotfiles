(fn []
  (let [lspconfig (require :lspconfig)
        typescript-tools (require :typescript-tools)]
    (lspconfig.fennel_language_server.setup {:settings {:fennel {:diagnostics {:globals [:vim]}
                                                                 :workspace {:library (vim.api.nvim_list_runtime_paths)}}}})
    (typescript-tools.setup {:expose_as_code_action :all
                             :tsserver_file_preferences {:importModuleSpecifierPreference :non-relative}})
    {}))
