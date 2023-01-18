local name = 'dashboard'
local utils = require('utils').start_script(name)
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

dashboard.section.header.val = {
    '                                                     ',
    '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
    '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
    '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
    '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
    '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
    '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
    '                                                     ',
}

dashboard.section.buttons.val = {
    dashboard.button( 'e', '  > New file' , ':ene <BAR> startinsert <CR>'),
    dashboard.button( 'f', '  > Find file', ':cd $HOME | Telescope find_files<CR>'),
    dashboard.button( 'r', '  > Recent'   , ':Telescope oldfiles<CR>'),
    dashboard.button( 'q', '  > Quit', ':qa<CR>'),
}

-- Setup the dashboard
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])

utils.end_script(name)
