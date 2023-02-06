local name = 'setup_dressing'
local utils = require('utils').start_script(name)

local m = require('dressing')
m.setup({
  input = {
    relative = "editor"
  },
})

utils.end_script(name)

