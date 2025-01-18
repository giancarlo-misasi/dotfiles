local M = {}

M.default_setup = function(server_name, opts)
  local lspconfig = require("lspconfig")
  local cmp = require('blink.cmp')
  opts = vim.tbl_deep_extend("force", {
    autostart = false,
    capabilities = cmp.get_lsp_capabilities(),
  }, opts or {})
  lspconfig[server_name].setup(opts)
end

M.default_start = function(server_name)
  vim.cmd("LspStart " .. server_name)
end

M.start = function()
  require("plugins.lsp.config." .. vim.bo.filetype).start()
end

M.is_running = function()
  return #vim.lsp.get_clients() > 0
end

M.toggle = function()
  if M.is_running() then
    vim.cmd("LspStop ++force")
  else
    M.start()
  end
end

return M
