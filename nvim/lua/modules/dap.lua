local M = {}

M.start = function()
  -- load lazy plugins
  require("dap")

  -- load the language specific configuration and start
  require("plugins.dap.config." .. vim.bo.filetype).start()
end

return M
