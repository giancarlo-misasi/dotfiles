local name = 'setup_treesitter'
local utils = require('utils').start_script(name)

local m = require('nvim-treesitter.configs')
local keymaps = require('keymaps')
local lang = require('languages')
m.setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = lang.treesitter_languages,
    auto_install = true,
    highlight = {
        enable = true,
    },
    autotag = { 
        enable = true
    },
    indent = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = keymaps.incremental_selection_keymaps,
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

local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)
-- Make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)

-- Folding
vim.opt.foldcolumn = 'auto'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

utils.end_script(name)
