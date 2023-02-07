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
local dap = require('dap')
local dap_ui = require('dapui')
local dap_virtual_text = require('nvim-dap-virtual-text')

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

-- dap setup
-- enable cpptools
-- vim.cmd('MasonInstall cpptools') -- todo: setup ensure installed for this
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = 'OpenDebugAD7',
}

-- enable reading vscode launch.json
require('dap.ext.vscode').load_launchjs(nil, { cppdbg = {'c', 'cpp'} })

-- enable dap ui
dap_ui.setup({
  -- layouts = {
  --   {
  --     elements = { -- console is hidden since it doesn't do much
  --       { id = "stacks", size = 0.2 },
  --       { id = "scopes", size = 0.2, },
  --       { id = "watches", size = 0.2 },
  --       { id = "breakpoints", size = 0.2 },
  --       { id = "repl", size = 0.2 },
  --     },
  --     size = 40,
  --     position = "left",
  --   },
  -- },
})
dap_virtual_text.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dap_ui.open()
end

-- define debug icons
vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#460000" })
vim.fn.sign_define('DapBreakpoint', { text='', texthl='Error', numhl='Error' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='Error', numhl='Error' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='Warning', numhl= 'Warning' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='Information', numhl= 'Information' })
vim.fn.sign_define('DapStopped', { text='', texthl='Hint', numhl= 'Hint', linehl='DapStoppedLinehl' })

-- setup auto-pairs
pairs.setup { check_ts = true }
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- setup code-action lightbulb
lightbulb.setup({ virtual_text = { enabled = true }, status_text = { enabled = true }, autocmd = { enabled = true } })

utils.end_script(name)
