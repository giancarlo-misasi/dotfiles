local name = 'setup_persisted'
local utils = require('utils').start_script(name)

local m = require('persisted')
m.setup({
  use_git_branch = true,
  autoload = true,
})

local telescope = require('telescope')
telescope.load_extension("persisted")

utils.end_script(name)

