local commands = {
    "command! Actions Telescope menu action_menu",

    "command! SplitRight vsplit",
    "command! SplitDown split",
    "command! CloseSplit q!",
    "command! NewTab tabnew",
    "command! CloseTab tabclose",

    "command! FindFiles Telescope find_files",
    "command! LiveGrep Telescope live_grep",
    "command! RecentFiles Telescope oldfiles",
    "command! SearchHistory Telescope search_history",
    "command! SetLanguage Telescope filetypes",
    "command! Registers Telescope registers",
    "command! Commands Telescope commands",
    "command! CommandHistory Telescope command_history",
    "command! Diagnostics Telescope diagnostics",
    "command! Buffers Telescope buffers",
    "command! SearchKeymaps lua require('keymap-menu').select_keymap()",
    "command! StartLsp lua require('plugins.lsp.start').start()",
    "command! Rename lua vim.lsp.buf.rename()",
    "command! FormatCode lua vim.lsp.buf.format()",
    "command! CodeActions lua vim.lsp.buf.code_action()",
    "command! Hover lua vim.lsp.buf.hover()",
    "command! ShowReferences lua vim.lsp.buf.references()",
    "command! ShowSignature lua vim.lsp.buf.signature_help()",
    "command! GotoDefinition lua vim.lsp.buf.definition()",
    "command! GotoDeclaration lua vim.lsp.buf.declaration()",
    "command! GotoImplementation lua vim.lsp.buf.implementation()",
    "command! GotoType lua vim.lsp.buf.type_definition()",
    "command! Debug DapContinue",

    "command! Quit qa!",
}

local function setup_commands(commands)
    for _, cmd in pairs(commands) do
        local status, exception = pcall(function()
            vim.api.nvim_command(cmd)
        end)
        if not status then
            print("failed to set command " .. cmd .. ": " .. exception)
        end
    end
end

local function setup_highlight_on_yank()
    vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
            vim.highlight.on_yank()
        end
    })
end

local function setup_q_close_for_buffers()
    vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'qf', 'help', 'man', 'netrw', 'lspinfo' },
        callback = function()
            vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
        end
    })
end

local function setup_open_directory_as_cwd()
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            local arg = vim.fn.argv(0)
            if vim.fn.isdirectory(arg) == 1 then
                vim.cmd('cd ' .. arg)
                require("telescope.builtin").oldfiles()
            end
        end,
    })
end

setup_commands(commands)
setup_highlight_on_yank()
setup_q_close_for_buffers()
setup_open_directory_as_cwd()
