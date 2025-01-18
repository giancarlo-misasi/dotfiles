local M = {}

-- setup adapter and configuration
require("dap-go").setup()

M.start = function()
  -- debug target at current cursor position
  require('dap-go').debug_test()
end

return M
