local M = {}

local lsp_utils = require("modules.lsp")
local server_name = "lua_ls"
lsp_utils.default_setup(server_name, {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})

M.start = function()
  lsp_utils.default_start(server_name)
end

return M
