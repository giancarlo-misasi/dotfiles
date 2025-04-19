-- https://mason-registry.dev/
local tools = {
  "clangd",
  "rust-analyzer",
  "codelldb",
  "lua-language-server",
  "gopls",
  "pyright",
  "ruff",
  "jdtls",
  "marksman",
  "zls",
}

return {
  {
    "williamboman/mason.nvim",
    opts = {},
    lazy = true,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
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
