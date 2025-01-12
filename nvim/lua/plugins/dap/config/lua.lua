local M = {}

local dap = require("dap")

-- setup adapter
require("plugins.dap.adapters.luadb")

-- setup configuration
dap.configurations.lua = {
  {
    name = 'Launch',
    type = 'luadb',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = {
      lua = 'lua',
      file = '${file}',
    },
    args = {},
  },
}

M.start = function()
  vim.cmd("DapContinue")
end

return M
