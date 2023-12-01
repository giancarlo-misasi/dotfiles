local name = 'languages'
local utils = require('utils').start_script(name)
local M = {}

M.treesitter_languages = {
    'make',
    'cmake',
    'c',
    'cpp',
    'go',
    'python',
    'ruby',
    'rust',
    'lua',
    'markdown',
    'yaml',
}

utils.end_script(name)
return M
