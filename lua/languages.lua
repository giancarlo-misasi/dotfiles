local name = 'languages'
local utils = require('utils').start_script(name)
local M = {}

M.treesitter_languages = { 
    'make',
    'cmake',
    'c',
    'cpp',
    'go',
    'jq',
    'java',
    'lua',
    'markdown',
}

M.lsp_languages = {
    -- c++
    'clangd',

    -- go
    'gopls',

    -- markdown
    'marksman',
}

M.lsp_linters_and_formatters = {
    'cpplint',
    'gofumpt',
}

utils.end_script(name)
return M
