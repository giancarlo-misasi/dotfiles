local name = 'setup_osc52'
local utils = require('utils').start_script(name)

local m = require('osc52')
m.setup({
  silent = true
})

utils.end_script(name)

