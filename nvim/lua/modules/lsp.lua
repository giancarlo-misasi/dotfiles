local M = {}

-- https://mason-registry.dev/
local cfg = {
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

local function get_lsp_clients(ft)
  return cfg[ft] and cfg[ft].lsp_clients
end

local function start()
  local clients = get_lsp_clients(vim.bo.filetype)
  if clients then
    vim.lsp.enable(clients, true)
  end
end

local function stop()
  local clients = get_lsp_clients(vim.bo.filetype)
  if clients then
    vim.lsp.enable(clients, false)
    vim.lsp.stop_client(vim.lsp.get_clients())
  end
end

M.is_running = function()
  local clients = get_lsp_clients(vim.bo.filetype)
  if not clients then
    return false
  end

  local running_clients = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    running_clients[client.name] = true
  end

  for _, client in ipairs(clients) do
    if running_clients[client] then
      return true
    end
  end

  return false
end

M.toggle = function()
  require("mason-tool-installer") -- lazy load mason
  require("lspconfig")            -- use default lsp configs
  -- NOTE: lsp config overrides are in nvim/lsp/*

  if M.is_running() then
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
