local name = 'setup_alpha'
local utils = require('utils').start_script(name)

local m = require('alpha')
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
    dashboard.button( 'h', '  > Find in home', ':cd $HOME | Telescope find_files<CR>'),
    dashboard.button( 'f', '  > Find in current', ':Telescope find_files<CR>'),
    dashboard.button( 'r', '  > Recent'   , ':Telescope oldfiles<CR>'),
    dashboard.button( 'q', '  > Quit', ':qa<CR>'),
}

-- Setup the dashboard
m.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])

utils.end_script(name)
