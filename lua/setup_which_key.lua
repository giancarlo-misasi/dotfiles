local name = 'setup_which_key'
local utils = require('utils').start_script(name)

local m = require('which-key')
vim.o.timeout = true
vim.o.timeoutlen = 500
m.setup()

utils.end_script(name)
