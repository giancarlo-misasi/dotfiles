local name = 'setup_colorizer'
local utils = require('utils').start_script(name)

local m = require('colorizer')
m.setup()

utils.end_script(name)
