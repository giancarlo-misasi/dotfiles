local name = 'commands'
local utils = require('utils').start_script(name)

vim.cmd [[
  augroup _general_settings
    au!
    au FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    au TextYankPost * silent!lua require('vim.highlight').on_yank() 
    au BufWinEnter * :set formatoptions-=cro
  augroup end
]]

utils.end_script(name)
