local keymaps = require("modules.keymaps")

local tools = {
    "clangd",
    "lua_ls",
    "rust_analyzer",
    "gopls",
    "jdtls",
    "java-test",
    "java-debug-adapter",
    "pyright",
    "marksman",
}

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        event = "VeryLazy",
        dependencies = {
            -- basics
            "neovim/nvim-lspconfig",
            -- packages to intall lsps
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            -- autocomplete
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()
            lsp_zero.on_attach(function(_, bufnr)
                for _, k in pairs(keymaps.lsp) do
                    vim.keymap.set(k.mode, k.lhs, k.rhs, { desc = k.desc, buffer = bufnr })
                end
            end)

            require("mason").setup()
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        require("modules.lsp").setup(server_name)
                    end
                }
            })
            require("mason-tool-installer").setup({
                ensure_installed = tools,
                run_on_start = false,
                auto_update = false,
            })

            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()
            local km = keymaps.autocomplete;
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    [km.confirm] = cmp.mapping.confirm({ select = false }),
                    [km.complete] = cmp.mapping.confirm(),
                    [km.move_up] = cmp.mapping.select_prev_item({ behavior = "select" }),
                    [km.move_down] = cmp.mapping.select_next_item({ behavior = "select" }),
                    [km.toggle] = cmp_action.toggle_completion(),
                }),
            })

            require("nvim-autopairs").setup({ check_ts = true })
            cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
        end
    },
    {
        "mfussenegger/nvim-jdtls",
        event = "VeryLazy",
    },
}
