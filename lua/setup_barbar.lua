local name = 'setup_barbar'
local utils = require('utils').start_script(name)

local m = require('bufferline')
m.setup()

utils.end_script(name)
