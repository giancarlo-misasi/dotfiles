local enable_ux_plugins = not vim.g.vscode

local external_commands = {
    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
}

local menus = {
    action_items = {
        { "Install treesitter languages", "TSUpdate" },
        { "Install lsp tools",            "MasonToolsUpdate" },

        { "Split right",                  "SplitRight" },
        { "Split down",                   "SplitDown" },
        { "Close split",                  "CloseSplit" },
        { "New tab",                      "NewTab" },
        { "Close tab",                    "CloseTab" },

        { "Find files",                   "FindFiles" },
        { "Live grep",                    "LiveGrep" },
        { "Recent files",                 "RecentFiles" },
        { "Search history",               "SearchHistory" },
        { "Set language",                 "SetLanguage" },
        { "Registers",                    "Registers" },
        { "Commands",                     "Commands" },
        { "Command history",              "CommandHistory" },
        { "Diagnostics",                  "Diagnostics" },
        { "Buffers",                      "Buffers" },
        { "Search keymaps",               "SearchKeymaps" },

        { "Start lsp",                    "StartLsp" },
        { "Stop lsp",                     "LspStop" },
        { "Show lsp status",              "LspInfo" },
        { "Rename",                       "Rename" },
        { "Format code",                  "FormatCode" },
        { "Code actions",                 "CodeActions" },
        { "Hover",                        "Hover" },
        { "Show references",              "ShowReferences" },
        { "Show signature",               "ShowSignature" },
        { "Goto definition",              "GotoDefinition" },
        { "Goto declaration",             "GotoDeclaration" },
        { "Goto implementation",          "GotoImplementation" },
        { "Goto type",                    "GotoType" },
        { "Debug",                        "Debug" },

        { "Quit",                         "Quit" },
    },
}

return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        cond = enable_ux_plugins,
        event = "VeryLazy",
        build = "make",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        cond = enable_ux_plugins,
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "octarect/telescope-menu.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
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
