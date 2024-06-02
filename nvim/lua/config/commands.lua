local commands = {
    'command! SelectKeymap lua require("keymap-menu").select_keymap()',

    "command! SplitRight vsplit",
    "command! SplitDown split",
    "command! CloseSplit q!",
    "command! NewTab tabnew",
    "command! CloseTab tabclose",

    "command! FindFiles Telescope find_files",
    "command! LiveGrep Telescope live_grep",
    "command! OldFiles Telescope oldfiles",
    "command! SearchHistory Telescope search_history",
    "command! SetLanguage Telescope filetypes",
    "command! Registers Telescope registers",
    "command! Commands Telescope commands",
    "command! CommandHistory Telescope command_history",
    "command! Diagnostics Telescope diagnostics",
    "command! Buffers Telescope buffers",
    "command! Actions Telescope menu action_menu",

    "command! FindReferences lua vim.lsp.buf.references()",
    "command! FormatCode lua vim.lsp.buf.format()",
    "command! GotoDeclaration lua vim.lsp.buf.declaration()",
    "command! GotoImplementation lua vim.lsp.buf.implementation()",
    "command! Rename lua vim.lsp.buf.rename()",
    "command! Hover lua vim.lsp.buf.hover()",
    "command! SignatureHelp lua vim.lsp.buf.signature_help()",
    "command! CodeActions lua vim.lsp.buf.code_action()",

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
		pattern = {'qf', 'help', 'man', 'netrw', 'lspinfo'},
		callback = function()
		  vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
		end
	})
end

setup_commands(commands)
setup_highlight_on_yank()
setup_q_close_for_buffers()
