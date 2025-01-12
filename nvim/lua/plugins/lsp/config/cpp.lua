local M = {}

local lsp_utils = require("modules.lsp")
local server_name = "clangd"
lsp_utils.default_setup(server_name, {})

M.start = function()
  lsp_utils.default_start(server_name)
end

return M
