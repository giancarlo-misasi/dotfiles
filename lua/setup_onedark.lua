local name = 'setup_onedark'
local utils = require('utils').start_script(name)

local m = require('onedark')
local colors = require('lsp-colors')
m.setup {
    style = 'warmer',
    lualine = {
        transparent = true,
    },
    code_style = {
        comments = 'none'
    },
}
m.load()
colors.setup()

utils.end_script(name)
