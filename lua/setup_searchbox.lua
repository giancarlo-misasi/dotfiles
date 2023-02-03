local name = 'setup_searchbox'
local utils = require('utils').start_script(name)

local m = require('searchbox')
m.setup({
  defaults = {
    show_matches = true,
    confirm = "menu",
  }
})

utils.end_script(name)

