local M = {}

local lsp_utils = require("modules.lsp")
lsp_utils.default_setup("ruff", {})
lsp_utils.default_setup("pyright", {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
})

M.start = function()
  lsp_utils.default_start("ruff")
  lsp_utils.default_start("pyright")
end

return M
