local actions = require("config.actions")
local enable_ux_plugins = not vim.g.vscode

local external_commands = {
  find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
}

local menu_items = {}
for _, action in ipairs(actions) do
  table.insert(menu_items, { action[1], action[3] })
end

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
      "nvim-telescope/telescope-fzf-native.nvim",
      "octarect/telescope-menu.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "smart" },
          file_ignore_patterns = {
            "%.git/.*",
            "build/.*",
            "target/.*",
            "bin/.*",
            "out/.*",
            "dist/.*",
            "%.cache/.*",
            "%.idea/.*",
            "%.class",
            "%.jar",
            "%.gradle/.*",
            "gradle/.*",
            "node_modules/.*",
            "__pycache__/.*",
            "venv/.*",
            "env/.*",
            ".env/.*",
          },
        },
        pickers = {
          find_files = { find_command = external_commands.find_command },
        },
        extensions = {
          menu = {
            action_menu = { items = menu_items },
          },
        },
      })
      telescope.load_extension("fzf")
      telescope.load_extension("menu")
      telescope.load_extension("live_grep_args")
    end,
  },
}
