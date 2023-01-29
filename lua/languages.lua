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
    'java',
    'kotlin',
    'scala',
    'javascript',
    'c_sharp',
    'regex',
    'jq',
    'yaml',
    'vim',
}

M.lsp_languages = {
    -- c++
    'clangd',

    -- go
    'gopls',

    -- python
    'jedi_language_server',

    -- ruby
    'ruby_ls',

    -- rust
    'rust_analyzer',

    -- lua
    'sumneko_lua',

    -- markdown
    'marksman',
}

M.lsp_linters_and_formatters = {
    'gofumpt',
}

utils.end_script(name)
return M
