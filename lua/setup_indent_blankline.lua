local name = 'setup_indent_blankline'
local utils = require('utils').start_script(name)

local m = require('indent_blankline')
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
vim.g["indent_blankline_char"] = "⁞"
vim.g["indent_blankline_context_char"] = "⁞"
m.setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context = true,
}

utils.end_script(name)
