local keymaps = require("config.keymaps")
local languages = {
  "c",
  "cpp",
  "lua",
  "python",
  "java",
  "kotlin",
  "typescript",
  "dockerfile",
  "markdown",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    lazy = false,
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
          move = false,
          select = {
            enable = true,
            lookahead = true,
            include_surrounding_whitespace = false,
            keymaps = keymaps.textobjects_select,
            selection_modes = {
              -- default is charwise
              ["@function.inner"] = "V", -- linewise
              ["@function.outer"] = "V", -- linewise
              ["@block.inner"] = "V",    -- linewise
              ["@block.outer"] = "V",    -- linewise
            },
          },
        },
      })
    end,
  },
}
