local M = {}

-- configure autocompletion
vim.g.rustaceanvim = {
  server = {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
  },
}

-- load lazy plugins
require("lspconfig")
require("rustaceanvim")

-- activate rustaceanvim
vim.cmd('doautocmd FileType rust')

-- rustaceanvim autostarts
M.start = function() end

return M
