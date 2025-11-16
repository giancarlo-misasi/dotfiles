local lsp = require("modules.lsp")
local tools = lsp.get_mason_packages()

return {
  {
    "mason-org/mason.nvim",
    opts = {},
    lazy = true,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    lazy = true,
    cmd = { "Mason", "MasonToolsUpdate" },
    opts = {
      ensure_installed = tools,
      run_on_start = false,
      auto_update = false,
    },
  }
}
