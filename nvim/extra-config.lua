require("typescript-tools").setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  tsserver_file_preferences = {
    importModuleSpecifierPreference = "non-relative",
  },
  expose_as_code_action = "all",
})

do
  local cmp = require("cmp")

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      },
    }),
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
end
