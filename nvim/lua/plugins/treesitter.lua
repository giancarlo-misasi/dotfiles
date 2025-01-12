local keymaps = require("config.keymaps")

local languages = {
  "c",
  "cpp",
  "rust",
  "lua",
  "go",
  "python",
  "java",
  "markdown",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    event = "VeryLazy",
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

      -- treesitter folding
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldmethod = "expr"

      -- enable repeat using treesitter.textobjects.repeatable_move
      require("modules.repeat")
    end,
  },
}
