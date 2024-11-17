local M = {}

M.setup = function()
    local dap = require("dap")

    local function path_to_exe()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end

    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
    }

    dap.configurations.c = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = path_to_exe,
            cwd = "${workspaceFolder}",
        },
    }

    dap.configurations.cpp = {
        {
            name = 'Launch',
            type = 'gdb',
            request = 'launch',
            program = path_to_exe,
            cwd = '${workspaceFolder}',
        },
    }
end

return M
