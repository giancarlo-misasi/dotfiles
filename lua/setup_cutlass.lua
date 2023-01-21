local name = 'setup_cutlass'
local utils = require('utils').start_script(name)

local m = require('cutlass')
m.setup {
    override_del = true
}

utils.end_script(name)
