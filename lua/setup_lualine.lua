local name = 'setup_lualine'
local utils = require('utils').start_script(name)

local m = require('lualine')
m.setup {
    options = {
        theme = 'onedark'
    }
}

utils.end_script(name)
