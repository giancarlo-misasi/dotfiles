local M = {}

local dap = require("dap")

-- setup adapter
require("plugins.dap.adapters.gdb")

-- setup configuration
dap.configurations.c = {
  {
    name = 'Launch',
    type = 'gdb',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    args = {},
  },
}

M.start = function()
  vim.cmd("DapContinue")
end

return M
