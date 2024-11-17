local keymaps = require("modules.keymaps")
local tools = require("modules.tools")

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        event = "VeryLazy",
        dependencies = {
            -- basics
            "neovim/nvim-lspconfig",
            -- packages to intall lsps
            "williamboman/mason.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            -- autocomplete
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",
        },
        config = function()
            -- Add autocomplete capabilities settings to lspconfig
            -- Enable keymaps that only work if an lsp is active in the file
            require("lsp-zero").extend_lspconfig({
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                lsp_attach = function(_, bufnr)
                    for _, k in pairs(keymaps.lsp) do
                        vim.keymap.set(k.mode, k.lhs, k.rhs, { desc = k.desc, buffer = bufnr })
                    end
                end,
            })
            
            -- Configure auto install of lsp, dap, linter, formatter etc
            require("mason").setup()
            require("mason-tool-installer").setup({
                ensure_installed = tools.tools,
                run_on_start = false,
                auto_update = false,
            })

            -- Configure autocomplete
            local cmp = require("cmp")
            local km = keymaps.autocomplete;
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
                snippet = {
                    expand = function(args)
                      vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    [km.confirm] = cmp.mapping.confirm({ select = false }),
                    [km.complete] = cmp.mapping.confirm(),
                    [km.move_up] = cmp.mapping.select_prev_item({ behavior = "select" }),
                    [km.move_down] = cmp.mapping.select_next_item({ behavior = "select" }),
                    [km.toggle] = cmp.mapping(function()
                        if cmp.visible() then
                          cmp.abort()
                        else
                          cmp.complete()
                        end
                    end, {}),
                }),
            })

            -- Configure closure autocomplete
            require("nvim-autopairs").setup({ check_ts = true })
            cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

            -- Configure lsp
            tools.setup_lsp()
        end
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = false,
        -- Force this to initialize after base lsp setup
        dependencies = { "VonHeikemen/lsp-zero.nvim" },
    },
    {
        "mfussenegger/nvim-jdtls",
        event = "VeryLazy",
        -- Force this to initialize after base lsp setup
        dependencies = { "VonHeikemen/lsp-zero.nvim" },
    },
}
