local M = {}

-- https://mason-registry.dev/
local cfg = {
  c = {
    lsp_servers = { "clangd" },
    mason_packages = { "clangd" }
  },
  cpp = {
    lsp_servers = { "clangd" },
    mason_packages = { "clangd" }
    -- includes clang-tidy and clang-format for linting and formatting
  },
  lua = {
    lsp_servers = { "lua_ls" },
    mason_packages = { "lua-language-server" }
    -- includes EmmyLuaCodeStyle for linting and formatting
  },
  python = {
    lsp_servers = { "ty", "ruff" },   -- pyright
    mason_packages = { "ty", "ruff" } -- pyright
    -- using ruff for linting and formatting
  },
  typescript = {
    lsp_servers = { "ts_ls" },
    mason_packages = { "typescript-language-server", "prettierd" }
    -- using eslint for linting and prettier for formatting
  },
  kotlin = {
    lsp_servers = { "kotlin_lsp" },
    mason_packages = { "kotlin-lsp" }
  },
  markdown = {
    lsp_servers = { "marksman" },
    mason_packages = { "marksman" }
    -- using prettier for formatting
  },
}

local function get_lsp_servers(ft)
  return cfg[ft] and cfg[ft].lsp_servers
end

local function start()
  local servers = get_lsp_servers(vim.bo.filetype)
  if servers then
    vim.lsp.enable(servers, true)
  end
end

local function stop()
  local servers = get_lsp_servers(vim.bo.filetype)
  if servers then
    vim.lsp.enable(servers, false)
    vim.lsp.stop_client(vim.lsp.get_clients())
  end
end

M.is_running = function()
  return #vim.lsp.get_clients() > 0
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
