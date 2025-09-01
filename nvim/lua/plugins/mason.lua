-- https://mason-registry.dev/
local tools = {
  -- c++
  -- includes clang-tidy and clang-format for linting and formatting
  "clangd",

  -- lua
  -- includes EmmyLuaCodeStyle for linting and formatting
  "lua-language-server",

  -- python
  -- uses ruff for linting and formatting
  "pyright",
  "ruff",

  -- typescript
  -- using eslint and prettier for linting and formatting
  "typescript-language-server",
  "prettierd",

  -- kotlin
  "kotlin-lsp",

  -- markdown
  "marksman",
}

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
