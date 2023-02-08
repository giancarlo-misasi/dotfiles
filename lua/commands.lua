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
  :command CloseTab tabclose
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
  :command FindFiles lua require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() })
  :command LiveGrep lua require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() })
  :command OldFiles Telescope oldfiles
  :command Commands Telescope commands
  :command Buffers Telescope buffers
  :command Registers Telescope registers
  :command RestoreSession lua require("persistence").load()
  :command Terminal ToggleTerm size=15 dir=. direction=horizontal
  :command RunTasks lua require('vscode').launch_new_task()
  :command RunTasksOld lua require('vscode').launch_old_task()
  :command ResetDebugParameters lua require('dap.ext.vscode').load_launchjs(nil, { cppdbg = {'c', 'cpp'} })
  :command GitBranches lua require('telescope.builtin').git_branches({ cwd = vim.fn.getcwd() })
  :command GitStatus lua require('telescope.builtin').git_status({ cwd = vim.fn.getcwd() })
  :command GitDiff DiffviewOpen<cr>
  :command Quit qa!
]]

utils.end_script(name)
