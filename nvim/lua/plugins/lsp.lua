local keymaps = require("keymaps")
local languages = require("languages")

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = "v3.x",
        event = "VeryLazy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "mfussenegger/nvim-jdtls",
            "windwp/nvim-autopairs",
            "kosayoda/nvim-lightbulb",
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()
            lsp_zero.on_attach(function(client, bufnr)
                for _, k in pairs(keymaps.lsp) do
                    vim.keymap.set(k.mode, k.lhs, k.rhs, { desc = k.desc, buffer = bufnr })
                end
            end)

            local mason = require("mason")
            mason.setup()

            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = languages.lsp,
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({
                            autostart = false
                        })
                    end,
                    jdtls = lsp_zero.noop,
                },
            })

            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()
            local km = keymaps.autocomplete;
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    [km.confirm] = cmp.mapping.confirm({ select = false }),
                    [km.complete] = cmp.mapping.confirm(),
                    [km.move_up] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    [km.move_down] = cmp.mapping.select_next_item({ behavior = 'select' }),
                    [km.toggle] = cmp_action.toggle_completion(),
                }),
            })

            local autopairs = require("nvim-autopairs")
            autopairs.setup({
                check_ts = true,
            })

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            local lightbulb = require("nvim-lightbulb")
            lightbulb.setup({
                autocmd = { enabled = true }
            })
        end
    },
}
