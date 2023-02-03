local name = 'setup_persistence'
local utils = require('utils').start_script(name)

local m = require('persistence')
m.setup()

utils.end_script(name)

