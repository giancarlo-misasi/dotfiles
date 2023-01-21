local name = 'setup_lsp'
local utils = require('utils').start_script(name)

local lsp = require('lsp-zero')
local lang = require('languages')
local mason_null_ls = require('mason-null-ls')

lsp.preset('recommended')
lsp.ensure_installed(lang.lsp_languages)
lsp.setup()

-- TODO: Decide if I want to change cmp auto-complete behavior

-- Auto-wire in formatters for null-ls
mason_null_ls.setup({
  ensure_installed = lang.lsp_linters_and_formatters,
  automatic_setup = true,
})

utils.end_script(name)
