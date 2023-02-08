local name = 'setup_theme'
local utils = require('utils').start_script(name)

vim.cmd([[
    colorscheme onedark
    hi DiffAdd      guibg=#215646
    hi DiffDelete   guibg=#5e2b40
    hi DiffChange   guibg=#2e324b
    hi DiffText     guibg=#1d202f
]])

utils.end_script(name)
