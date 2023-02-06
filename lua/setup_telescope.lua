local name = 'setup_telescope'
local utils = require('utils').start_script(name)

local m = require("telescope")
local actions = require "telescope.actions"
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
  extensions = {
    menu = {
      file_menu = {
        items = {
          {'Find files', 'FindFiles'},
          {'Live grep', 'LiveGrep'},
          {'Old files', 'OldFiles'},
          {'Buffers', 'Buffers'},
          {'Registers', 'Registers'},
          {'New tab', 'NewTab'},
          {'Split right', 'SplitRight'},
          {'Split down', 'SplitDown'},
          {'Restore session', 'RestoreSession'}
        },
      },
      lsp_menu = {
        items = {
          { 'Goto definition', 'GotoDefinition' },
          { 'Goto type definition', 'GotoTypeDefinition' },
          { 'Goto declaration', 'GotoDeclaration' },
          { 'Goto implementation', 'GotoImplementation' },
          { 'Find references', 'FindReferences' },
          { 'Hover', 'Hover' },
          { 'Signature help', 'SignatureHelp'},
          { 'Code actions', 'CodeActions' },
          { 'Quick Fixes', 'QuickFixes'},
          { 'Locations', 'Locations'},
          { 'Rename', 'Rename' },
        },
      },
    }
  },
}

-- Load telescope extensions
m.load_extension('fzf')
m.load_extension('menu')

-- Setup keymaps
keymaps.set_keymaps(keymaps.telescope_keymaps(builtin))

utils.end_script(name)
