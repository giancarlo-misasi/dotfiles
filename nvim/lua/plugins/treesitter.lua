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
  "html",
  "regex",
  "json",
  "ruby",
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
      local max_filesize = 100 * 1024
      configs.setup({
        ensure_installed = languages,
        auto_install = false,
        indent = true,
        incremental_selection = false,
        highlight = {
          enable = true,
          disable = function(_, buf)
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
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

      -- enable repeat using treesitter.textobjects.repeatable_move
      require("modules.repeat")
    end,
  },
}
