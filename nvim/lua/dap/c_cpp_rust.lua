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

    dap.configurations.rust = {
        {
            name = 'Launch',
            type = 'gdb',
            request = 'launch',
            program = path_to_exe,
            cwd = '${workspaceFolder}',
            initCommands = function()
                local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))
                local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
                local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'
                local commands = {}
                local file = io.open(commands_file, 'r')
                if file then
                    for line in file:lines() do
                        table.insert(commands, line)
                    end
                    file:close()
                end
                table.insert(commands, 1, script_import)
                return commands
            end,
        }
    }
end

return M
