local enable_ux_plugins = not vim.g.vscode
local menus = require("config.menus")

local external_commands = {
  find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
}

return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    cond = enable_ux_plugins,
    lazy = true,
    build = "make",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    cond = enable_ux_plugins,
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "octarect/telescope-menu.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "smart" },
        },
        pickers = {
          find_files = { find_command = external_commands.find_command },
        },
        extensions = {
          menu = {
            action_menu = { items = menus.action_items },
          },
        },
      })
      telescope.load_extension("ui-select")
      telescope.load_extension("menu")
      telescope.load_extension('fzf')
    end,
  },
}
