local name = 'setup_dressing'
local utils = require('utils').start_script(name)

local m = require('dressing')
m.setup({
  select = {
    telescope = require('telescope.themes').get_cursor()
  },
})

utils.end_script(name)

