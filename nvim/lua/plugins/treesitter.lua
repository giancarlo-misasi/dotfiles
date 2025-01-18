local keymaps = require("config.keymaps")
local max_filesize = 100 * 1024
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

      -- treesitter folding
      -- only enable for small files otherwise it can significantly slow down neovim
      vim.api.nvim_create_autocmd("BufReadPre", {
        pattern = "*",
        callback = function()
          local file_size = vim.fn.getfsize(vim.fn.expand("%:p"))
          if file_size > max_filesize then
            vim.wo.foldmethod = "indent"
          else
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end
        end,
      })

      -- enable repeat using treesitter.textobjects.repeatable_move
      require("modules.repeat")
    end,
  },
}
