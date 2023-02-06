local name = 'setup_toggleTerm'
local utils = require('utils').start_script(name)

local m = require('toggleterm')
m.setup()

utils.end_script(name)
