local name = 'keymaps'
local utils = require('utils').start_script(name)

local M = {}

-- Remap leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = n
--   insert_mode = i
--   visual_mode = v
--   visual_block_mode = x
--   term_mode = t
--   command_mode = c

M.keymaps = {
  { name = 'copy',               mode = 'v', map = '<C-c>',      cmd = '"+y',                                                     opts = { noremap = true, silent = true } }, --general
  { name = 'cut',                mode = 'v', map = '<C-x>',      cmd = '"+x',                                                     opts = { noremap = true, silent = true } },
  { name = 'paste',              mode = 'i',  map = '<C-v>',     cmd = '"+gP',                                                    opts = {} },
  { name = 'paste',              mode = 'c', map = '<C-v>',      cmd = '<C-r><C-r>+',                                             opts = {} },
  { name = 'paste register',     mode = 'n', map = '<C-p>',      cmd = '"',                                                       opts = { noremap = true, silent = true } },
  { name = 'paste register',     mode = 'i', map = '<C-p>',      cmd = '<C-o>"',                                                  opts = { noremap = true, silent = true } },
  { name = 'redo',               mode = 'i', map = '<C-r>',      cmd = '<C-o><C-r>',                                              opts = { noremap = true, silent = true } },
  { name = 'undo',               mode = 'n', map = '<C-z>',      cmd = 'u',                                                       opts = { noremap = true, silent = true } },
  { name = 'undo',               mode = 'i', map = '<C-z>',      cmd = '<C-o>u',                                                  opts = { noremap = true, silent = true } },
  { name = 'save',               mode = 'n', map = '<C-s>',      cmd = ':update<CR>',                                             opts = { noremap = true, silent = true } },
  { name = 'save',               mode = 'i', map = '<C-s>',      cmd = '<Esc>:update<CR>gi',                                      opts = { noremap = true, silent = true } },
  { name = 'save',               mode = 'v', map = '<C-s>',      cmd = '<C-c>:update<CR>',                                        opts = { noremap = true, silent = true } },
  { name = 'split right',        mode = 'n', map = '<C-Right>',  cmd = ':vsp<Enter>',                                             opts = { noremap = true, silent = true } }, -- split panes
  { name = 'split down',         mode = 'n', map = '<C-Down>',   cmd = ':sp<Enter>',                                              opts = { noremap = true, silent = true } },
  { name = 'move text down',     mode = 'n', map = '<A-Down>',   cmd = ':m .+1<CR>==',                                            opts = { noremap = true, silent = true } }, -- move text
  { name = 'move text up',       mode = 'n', map = '<A-Up>',     cmd = ':m .-2<CR>==',                                            opts = { noremap = true, silent = true } },
  { name = 'move text down',     mode = 'i', map = '<A-Down>',   cmd = '<Esc>:m .+1<CR>==gi',                                     opts = { noremap = true, silent = true } },
  { name = 'move text up',       mode = 'i', map = '<A-Up>',     cmd = '<Esc>:m .-2<CR>==gi',                                     opts = { noremap = true, silent = true } },
  { name = 'move text down',     mode = 'v', map = '<A-Down>',   cmd = ":m '>+1<CR>gv=gv",                                        opts = { noremap = true, silent = true } },
  { name = 'move text up',       mode = 'v', map = '<A-Up>',     cmd = ":m '<-2<CR>gv=gv",                                        opts = { noremap = true, silent = true } },
  { name = 'jump back',          mode = 'n', map = '<A-Left>',   cmd = '<C-o>',                                                   opts = { noremap = true, silent = true } }, -- jump lists
  { name = 'jump forward',       mode = 'n', map = '<A-Right>',  cmd = '<C-i>',                                                   opts = { noremap = true, silent = true } },
  { name = 'indent',             mode = 'n', map = '<Tab>',      cmd = '>>',                                                      opts = { noremap = true, silent = true } }, -- indentation
  { name = 'indent',             mode = 'v', map = '<Tab>',      cmd = '>gv',                                                     opts = { noremap = true, silent = true } },
  { name = 'reverse indent',     mode = 'n', map = '<S-Tab>',    cmd = '<<',                                                      opts = { noremap = true, silent = true } },
  { name = 'reverse indent',     mode = 'v', map = '<S-Tab>',    cmd = '<gv',                                                     opts = { noremap = true, silent = true } },
  { name = 'reverse indent',     mode = 'i', map = '<S-Tab>',    cmd = '<C-D>',                                                   opts = { noremap = true, silent = true } },
  { name = 'substitute',         mode = 'n', map = '<leader>s',  cmd = '<cmd>lua require("substitute").operator()<cr>',           opts = { noremap = true, silent = true } }, --substitute
  { name = 'substitute',         mode = 'x', map = '<leader>s',  cmd = '<cmd>lua require("substitute").visual()<cr>',             opts = { noremap = true, silent = true } },
  { name = 'substitute line',    mode = 'n', map = '<leader>ss', cmd = '<cmd>lua require("substitute").line()<cr>',               opts = { noremap = true, silent = true } },
  { name = 'substitute eol',     mode = 'n', map = '<leader>se', cmd = '<cmd>lua require("substitute").eol()<cr>',                opts = { noremap = true, silent = true } },
}

for _, k in pairs(M.keymaps) do
  if not k.buf then
    vim.api.nvim_set_keymap(k.mode, k.map, k.cmd, k.opts)
  end
end

utils.end_script(name)
return M
