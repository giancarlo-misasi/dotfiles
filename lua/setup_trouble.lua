local name = 'setup_trouble'
local utils = require('utils').start_script(name)

local trouble = require('trouble')
local keymaps = require('keymaps')
trouble.setup()
keymaps.set_keymaps(keymaps.trouble_keymaps())

utils.end_script(name)
