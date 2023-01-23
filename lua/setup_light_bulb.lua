local name = 'setup_light_bulb'
local utils = require('utils').start_script(name)

local m = require('nvim-lightbulb')
m.setup({
  virtual_text = {
    enabled = true,
  },
  status_text = {
    enabled = true,
  },
  autocmd = {
    enabled = true,
  }
})

utils.end_script(name)
