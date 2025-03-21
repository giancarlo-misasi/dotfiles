-- https://mason-registry.dev/
local tools = {
  "clangd",
  "rust-analyzer",
  "codelldb",
  "lua-language-server",
  "gopls",
  "pyright",
  -- "jdtls", -- installed by nvim-java
  "marksman",
}

return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {},
    lazy = true,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = true,
    cmd = { "MasonToolsUpdate" },
    opts = {
      ensure_installed = tools,
      run_on_start = false,
      auto_update = false,
    },
  }
}
