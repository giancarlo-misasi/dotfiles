local name = 'commands'
local utils = require('utils').start_script(name)

vim.cmd [[
  augroup _general_settings
    au!
    au FileType qf,help,man,netrw,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    au TextYankPost * silent!lua require('vim.highlight').on_yank() 
    au BufWinEnter * :set formatoptions-=cro
  augroup end

  set guicursor=n-v-c:block,i-ci-ve:ver30-Cursor/lCursor,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175
  hi CursorLine guibg=#363C46

  :command NewTab tabnew
  :command SplitRight vsplit
  :command SplitDown split
  :command GotoDefinition Trouble lsp_definitions
  :command GotoTypeDefinition Trouble lsp_type_definitions
  :command GotoDeclaration lua vim.lsp.buf.declaration()
  :command GotoImplementation lua vim.lsp.buf.implementation()
  :command FindReferences Trouble lsp_references
  :command FormatCode LspZeroFormat!
  :command Hover lua vim.lsp.buf.hover()
  :command SignatureHelp lua vim.lsp.buf.signature_help()
  :command CodeActions lua vim.lsp.buf.code_action()
  :command QuickFixes Trouble quickfix
  :command Locations Trouble loclist
  :command Rename lua vim.lsp.buf.rename()
  :command FindFiles lua require("telescope.builtin").find_files({ cwd = require("utils").cwd() })
  :command LiveGrep lua require("telescope.builtin").live_grep({ cwd = require("utils").cwd() })
  :command OldFiles Telescope oldfiles
  :command Commands Telescope commands
  :command Buffers Telescope buffers
  :command Registers Telescope registers
  :command RestoreSession lua require("persistence").load()
  :command Quit qa!
]]

-- debug signs
vim.fn.sign_define('DapBreakpoint', { text='', texthl='TroubleSignError', numhl='TroubleSignError' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='TroubleSignError', numhl='TroubleSignError' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='TroubleSignError', numhl= 'TroubleSignError' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='TroubleSignHint', numhl= 'TroubleSignHint' })
vim.fn.sign_define('DapStopped', { text='', texthl='TroubleSignOther', numhl= 'TroubleSignOther' })

utils.end_script(name)
