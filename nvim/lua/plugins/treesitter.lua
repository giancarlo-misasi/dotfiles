local keymaps = require("modules.keymaps")

local languages = {
    "c",
    "cpp",
    "lua",
    "rust",
    "go",
    "python",
    "java",
    "typescript",
    "markdown",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects"
        },
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = languages,
                auto_install = true,
                indent = true,
                incremental_selection = false,
                highlight = { enable = true },
                textobjects = {
                    swap = false,
                    select = {
                        enable = true,
                        lookahead = true,
                        include_surrounding_whitespace = true,
                        keymaps = keymaps.textobjects_select,
                        selection_modes = {
                            ["@parameter.outer"] = "v", -- charwise
                            ["@function.outer"] = "V",  -- linewise
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = keymaps.textobjects_move.goto_next_start,
                        goto_next_end = keymaps.textobjects_move.goto_next_end,
                        goto_previous_start = keymaps.textobjects_move.goto_previous_start,
                        goto_previous_end = keymaps.textobjects_move.goto_previous_end,
                        goto_next = {},
                        goto_previous = {},
                    },
                },
            })

            -- repeat treesitter moves
            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "repeat forward" })
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { desc = "repeat back" })
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

            -- treesitter folding
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt.foldmethod = "expr"
        end,
    },
}
