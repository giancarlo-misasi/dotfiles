local name = 'setup_lsp'
local utils = require('utils').start_script(name)

local lsp = require('lsp-zero')
local lang = require('languages')
local keymaps = require('keymaps')
local cmp = require('cmp')
local luasnip = require('luasnip')
local mason_null_ls = require('mason-null-ls')
local null_ls = require('null-ls')
local lspkind = require('lspkind')

lsp.preset('recommended')
lsp.ensure_installed(lang.lsp_languages)

-- fix for lua language server
lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
        diagnostics = {
            globals = { 'vim' }
        }
    }
  }
})

-- setup cmp auto-completion
lsp.setup_nvim_cmp({ 
  mapping = keymaps.cmp_keymaps(cmp, luasnip), 
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 25,
      ellipsis_char = '...',
    }),
  }
})

-- setup buffer keymaps
lsp.set_preferences({ set_lsp_keymaps = false })
lsp.on_attach(function(client, bufnr) keymaps.set_buf_keymaps(keymaps.lsp_keymaps(bufnr)) end)

-- initialize lsp-zero which wires everything together
lsp.setup()

-- Auto-wire in formatters for null-ls
mason_null_ls.setup({
  ensure_installed = lang.lsp_linters_and_formatters,
  automatic_setup = true,
})
null_ls.setup()
mason_null_ls.setup_handlers()

utils.end_script(name)
