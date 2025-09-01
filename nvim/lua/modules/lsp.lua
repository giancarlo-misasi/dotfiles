local M = {}

local servers_by_filetype = {
  c = { "clangd" },
  cpp = { "clangd" },
  lua = { "lua_ls" },
  python = { "pyright", "ruff" },
  kotlin = { "kotlin_lsp" },
  typescript = { "ts_ls" },
  markdown = { "marksman" },
}

local excluded_servers = {
  rust = true,
}

local function start()
  if not excluded_servers[vim.bo.filetype] then
    local servers = servers_by_filetype[vim.bo.filetype]
    if servers then
      vim.lsp.enable(servers_by_filetype[vim.bo.filetype], true)
    end
  end
end

local function stop()
  if not excluded_servers[vim.bo.filetype] then
    vim.lsp.enable(servers_by_filetype[vim.bo.filetype], false)
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

return M
