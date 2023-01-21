local name = 'setup_treesitter'
local utils = require('utils').start_script(name)

local m = require('nvim-treesitter.configs')
local keymaps = require('keymaps')
local lang = require('languages')
m.setup {
    ensure_installed = lang.treesitter_languages,
    auto_install = true,
    indent = false,
    incremental_selection = false,
    highlight = {
        enable = true,
    },
    textobjects = {
        swap = false,
        select = {
          enable = true,
          lookahead = true,
          include_surrounding_whitespace = true,
          keymaps = keymaps.textobjects_select_keymaps,
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
          },
        },
        move = utils.extend({
            enable = true,
            set_jumps = true,
        }, keymaps.textobjects_move_keymaps),
    },
}

-- Enable repeats
keymaps.set_treesitter_repeat_keymaps()

-- Folding
vim.opt.foldcolumn = 'auto'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Fold workaround for treesitter bug https://github.com/nvim-telescope/telescope.nvim/issues/699
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    command = "normal zx",
})

utils.end_script(name)
