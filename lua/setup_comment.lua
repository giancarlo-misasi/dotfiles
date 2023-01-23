local name = 'setup_comment'
local utils = require('utils').start_script(name)

local m = require('Comment')
local keymaps = require('keymaps')
m.setup(keymaps.comment_keymaps())

utils.end_script(name)
