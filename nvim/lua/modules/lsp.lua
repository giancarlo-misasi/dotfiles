local M = {}

local running = false
local cfg = {
  -- https://mason-registry.dev/
  c = {
    lsp_clients = { "clangd" },
    mason_packages = { "clangd" }
  },
  cpp = {
    lsp_clients = { "clangd" },
    mason_packages = { "clangd" }
    -- includes clang-tidy and clang-format for linting and formatting
  },
  lua = {
    lsp_clients = { "lua_ls" },
    mason_packages = { "lua-language-server" }
    -- includes EmmyLuaCodeStyle for linting and formatting
  },
  python = {
    lsp_clients = { "ty", "ruff" },   -- pyright
    mason_packages = { "ty", "ruff" } -- pyright
    -- using ruff for linting and formatting
  },
  typescript = {
    lsp_clients = { "ts_ls" },
    mason_packages = { "typescript-language-server", "prettierd" }
    -- using eslint for linting and prettier for formatting
  },
  kotlin = {
    lsp_clients = { "kotlin_lsp" },
    mason_packages = { "kotlin-lsp" }
  },
  markdown = {
    lsp_clients = { "marksman" },
    mason_packages = { "marksman" }
    -- using prettier for formatting
  },
}

local function start()
  for _, config in pairs(cfg) do
    vim.lsp.enable(config.lsp_clients, true)
  end
  running = true
end

local function stop()
  for _, lang in pairs(cfg) do
    vim.lsp.enable(lang.lsp_clients, false)
  end
  vim.lsp.stop_client(vim.lsp.get_clients())
  running = false
end

M.is_running = function()
  return running
end

M.toggle = function()
  require("mason-tool-installer") -- lazy load mason
  require("lspconfig")            -- use default lsp configs
  -- NOTE: lsp config overrides are in nvim/lsp/*

  if running then
    stop()
  else
    start()
  end

  vim.cmd("edit") -- reload the buffer
end

M.get_mason_packages = function()
  local packages = {}
  for _, config in pairs(cfg) do
    for _, package in ipairs(config.mason_packages) do
      table.insert(packages, package)
    end
  end
  return packages
end

return M
