return {
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            require("dap.c_cpp_rust").setup()
            require("dap-go").setup()

            vim.fn.sign_define('DapBreakpoint', { text = '' })
            vim.fn.sign_define('DapBreakpointCondition', { text = 'ﳁ' })
            vim.fn.sign_define('DapBreakpointRejected', { text = '' })
            vim.fn.sign_define('DapLogPoint', { text = '' })
            vim.fn.sign_define('DapStopped', { text = '' })
        end
    },
}
