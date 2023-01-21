local name = 'setup_onedark'
local utils = require('utils').start_script(name)

local m = require('onedark')
m.setup {
    style = 'warmer'
}
m.load() 

utils.end_script(name)
