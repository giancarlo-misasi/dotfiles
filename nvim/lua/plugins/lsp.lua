local keymaps = require("keymaps")
local languages = require("languages")

local function setup_lspzero()
    local lsp_zero = require("lsp-zero")
    lsp_zero.extend_lspconfig()
    lsp_zero.on_attach(function(client, bufnr)
        for _, k in pairs(keymaps.lsp) do
            vim.keymap.set(k.mode, k.lhs, k.rhs, { desc = k.desc, buffer = bufnr })
        end
    end)
end

local function setup_mason()
    local mason = require("mason")
    mason.setup({
        registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
        }
    })

    local lsp_zero = require("lsp-zero")
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
        ensure_installed = languages.lsp,
        handlers = {
            function(server_name)
                require("lspconfig")[server_name].setup({ autostart = false })
            end,
            jdtls = lsp_zero.noop,
        },
    })
end

local function setup_autocomplete()
    local lsp_zero = require("lsp-zero")
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

    local autopairs = require("nvim-autopairs")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    autopairs.setup({ check_ts = true })
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

local function setup_dap()
    require("dap.c_cpp_rust").setup()
    require("java").setup()
    require("dap-go").setup()

    local dapui = require("dapui")
    dapui.setup()

    local dap = require("dap")
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end
end

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

            -- autocomplete
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",

            -- debugging
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",

            -- language specific debugging extensions
            "leoluz/nvim-dap-go",

            -- java lsp support
            "nvim-java/nvim-java",
            "nvim-java/lua-async-await",
            "nvim-java/nvim-java-refactor",
            "nvim-java/nvim-java-core",
            "nvim-java/nvim-java-test",
            "nvim-java/nvim-java-dap",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            setup_lspzero()
            setup_mason()
            setup_autocomplete()
            setup_dap()
        end
    },
}
