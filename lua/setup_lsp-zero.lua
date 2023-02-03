local name = 'setup_lsp'
local utils = require('utils').start_script(name)

local lang = require('languages')
local keymaps = require('keymaps')

local lsp = require('lsp-zero')
local cmp = require('cmp')
local luasnip = require('luasnip')
local mason_null_ls = require('mason-null-ls')
local null_ls = require('null-ls')
local lspkind = require('lspkind')
local pairs = require('nvim-autopairs')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local lightbulb = require('nvim-lightbulb')
local mason_nvim_dap = require("mason-nvim-dap")

lsp.preset('recommended')
lsp.ensure_installed(lang.lsp_languages)
lsp.set_preferences({ set_lsp_keymaps = false })
lsp.on_attach(function(client, bufnr) keymaps.set_buf_keymaps(keymaps.lsp_keymaps(bufnr)) end)

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

-- initialize lsp-zero which wires everything together
lsp.setup()

-- mason null-ls setup
mason_null_ls.setup({ 
  ensure_installed = lang.lsp_linters_and_formatters, 
  automatic_setup = true
})
null_ls.setup()
mason_null_ls.setup_handlers()

-- mason nvim-dap setup
mason_nvim_dap.setup({
  ensure_installed = lang.debuggers,
  automatic_setup = true
})
mason_nvim_dap.setup_handlers()

-- setup auto-pairs
pairs.setup { check_ts = true }
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- setup code-action lightbulb
lightbulb.setup({ virtual_text = { enabled = true }, status_text = { enabled = true }, autocmd = { enabled = true } })

utils.end_script(name)
