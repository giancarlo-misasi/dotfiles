local name = 'setup_indent_blankline'
local utils = require('utils').start_script(name)

local m = require('ibl')
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
m.setup {}

utils.end_script(name)
