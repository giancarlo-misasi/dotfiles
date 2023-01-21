local name = 'setup_telescope'
local utils = require('utils').start_script(name)

local m = require("telescope")
local config = require("telescope.config")
local builtin = require('telescope.builtin')
local keymaps = require('keymaps')

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")

-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

-- Configure telescope
m.setup {
  defaults = {
    vimgrep_arguments = vimgrep_arguments,
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
}

-- Setup fzf
m.load_extension('fzf')

-- Setup keymaps
keymaps.set_keymaps(keymaps.telescope_keymaps(builtin))

utils.end_script(name)
