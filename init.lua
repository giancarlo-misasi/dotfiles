local enable_ux_plugins = not vim.g.vscode

local globals = {
	mapleader = " ",
	maplocalleader = " ",
	loaded_python3_provider = 0,
	loaded_ruby_provider = 0,
	loaded_perl_provider = 0,
	loaded_node_provider = 0,
	loaded_netrw = 1,
	loaded_netrwPlugin = 1,
	loaded_matchit = 1, -- turn off matchit extensions
}

local external_commands = {
	find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
}

local options = {
	clipboard = "unnamedplus",
	writebackup = false,
	swapfile = false,
	undofile = true,
	number = true,
	relativenumber = true,
	wrap = false,
	cursorline = true,
	termguicolors = true,
	signcolumn = "yes",
	showmode = true,
	showcmd = true,
	ignorecase = true,
	smartcase = true,
	incsearch = true,
	hlsearch = true,
	inccommand = "nosplit",
	tabstop = 2,
	softtabstop = -1,
	shiftwidth = 0,
	shiftround = true,
	expandtab = true,
	autoindent = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	mouse = "a",
	mousemodel = "popup",
	keymodel = "startsel",
	backspace = "indent,eol,start",
	whichwrap = "b,s,<,>,[,]",
	completeopt = { "menu", "menuone" }, -- autocomplete always select first item
	updatetime = 300, -- faster completion (4000ms default)
	pumheight = 6,
	fillchars = {
		horiz = "━",
		horizup = "┻",
		horizdown = "┳",
		vert = "┃",
		vertleft = "┫",
		vertright = "┣",
		verthoriz = "╋",
	},
}

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
	"command! FormatCode vim.lsp.buf.format()",
	"command! GotoDeclaration lua vim.lsp.buf.declaration()",
	"command! GotoImplementation lua vim.lsp.buf.implementation()",
	"command! Rename lua vim.lsp.buf.rename()",
	"command! Hover lua vim.lsp.buf.hover()",
	"command! SignatureHelp lua vim.lsp.buf.signature_help()",
	"command! CodeActions lua vim.lsp.buf.code_action()",

	"command! Quit qa!",
}

local menus = {
	action_items = {
		{ "Split right", "SplitRight" },
		{ "Split down", "SplitDown" },
		{ "Close split", "CloseSplit" },
		{ "New tab", "NewTab" },
		{ "Close tab", "CloseTab" },

		{ "Find files", "FindFiles" },
		{ "Live grep", "LiveGrep" },
		{ "Old files", "OldFiles" },
		{ "Search history", "SearchHistory" },
		{ "Set language", "SetLanguage" },
		{ "Registers", "Registers" },
		{ "Commands", "Commands" },
		{ "Command history", "CommandHistory" },
		{ "Diagnostics", "Diagnostics" },
		{ "Buffers", "Buffers" },

		{ "Find references", "FindReferences" },
		{ "Format code", "FormatCode" },
		{ "Goto declaration", "GotoDeclaration" },
		{ "Goto implementation", "GotoImplementation" },
		{ "Rename", "Rename" },
		{ "Hover", "Hover" },
		{ "Signature help", "SignatureHelp" },
		{ "Code actions", "CodeActions" },

		{ "Quit", "Quit" },
	},
}

local nops = {
	{ lhs = "q", rhs = "<Nop>" },
}

-- Modes
--   normal_mode = n
--   insert_mode = i
--   visual_mode = x
--   command_mode = c
-- Note: All keymaps here use noremap=true so that we can map to things that I have no-opped
local keymaps = {
	{ desc = "Select all", mode = "n", lhs = "<C-a>", rhs = "ggVG" },
	{ desc = "Select all", mode = "i", lhs = "<C-a>", rhs = "<Esc>ggVG" },
	{ desc = "Select all", mode = "x", lhs = "<C-a>", rhs = "<Esc>ggVG" },
	{ desc = "Copy", mode = "x", lhs = "<C-c>", rhs = '"+y' },
	{ desc = "Cut", mode = "x", lhs = "<C-x>", rhs = '"+x' },
	{ desc = "Paste", mode = "i", lhs = "<C-v>", rhs = '"+gP' },
	{ desc = "Paste", mode = "c", lhs = "<C-v>", rhs = "<C-r><C-r>+" },
	{ desc = "Undo", mode = "n", lhs = "<C-z>", rhs = "u" },
	{ desc = "Undo", mode = "i", lhs = "<C-z>", rhs = "<C-o>u" },
	{ desc = "Undo", mode = "x", lhs = "<C-z>", rhs = "<Esc>u" },
	{ desc = "Redo", mode = "n", lhs = "<C-y>", rhs = "<C-r>" },
	{ desc = "Redo", mode = "i", lhs = "<C-y>", rhs = "<C-o><C-r>" },
	{ desc = "Redo", mode = "x", lhs = "<C-y>", rhs = "<Esc><C-r>" },
	{ desc = "Save", mode = "n", lhs = "<C-s>", rhs = ":update<CR>" },
	{ desc = "Save", mode = "i", lhs = "<C-s>", rhs = "<Esc>:update<CR>gi" },
	{ desc = "Save", mode = "x", lhs = "<C-s>", rhs = "<Esc>:update<CR>" },
	{ desc = "Jump back", mode = "i", lhs = "<C-Left>", rhs = "<Esc>b" },
	{ desc = "Jump forward", mode = "i", lhs = "<C-Right>", rhs = "<Esc>w" },
	{ desc = "Move text down", mode = "n", lhs = "<A-Down>", rhs = ":m .+1<CR>==" },
	{ desc = "Move text down", mode = "i", lhs = "<A-Down>", rhs = "<Esc>:m .+1<CR>==gi" },
	{ desc = "Move text down", mode = "x", lhs = "<A-Down>", rhs = ":m '>+1<CR>gv=gv" },
	{ desc = "Move text up", mode = "n", lhs = "<A-Up>", rhs = ":m .-2<CR>==" },
	{ desc = "Move text up", mode = "i", lhs = "<A-Up>", rhs = "<Esc>:m .-2<CR>==gi" },
	{ desc = "Move text up", mode = "x", lhs = "<A-Up>", rhs = ":m '<-2<CR>gv=gv" },
	{ desc = "Jump list backward", mode = "n", lhs = "<A-Left>", rhs = "<C-o>" },
	{ desc = "Jump list forward", mode = "n", lhs = "<A-Right>", rhs = "<C-i>" },
	{ desc = "Indent", mode = "n", lhs = "<Tab>", rhs = ">>" },
	{ desc = "Indent", mode = "x", lhs = "<Tab>", rhs = ">gv" },
	{ desc = "Reverse indent", mode = "n", lhs = "<S-Tab>", rhs = "<<" },
	{ desc = "Reverse indent", mode = "i", lhs = "<S-Tab>", rhs = "<C-D>" },
	{ desc = "Reverse indent", mode = "x", lhs = "<S-Tab>", rhs = "<gv" },
	{ desc = "Actions", mode = "n", lhs = "<F1>", rhs = ":Actions<cr>" },
}

local autocomplete_keymaps = {
	confirm = "<CR>",
	complete = "<Tab>",
	move_up = "<Up>",
	move_down = "<Down>",
	toggle = "<C-Space>",
}

local lsp_keymaps = {
	{ desc = "Hover", mode = "n", lhs = "K",  rhs = "<cmd>lua vim.lsp.buf.hover()<cr>" },
	{ desc = "Goto defn", mode = "n", lhs = "gd", rhs = "<cmd>lua vim.lsp.buf.definition()<cr>" },
	{ desc = "Goto decl", mode = "n", lhs = "gD", rhs = "<cmd>lua vim.lsp.buf.declaration()<cr>" },
	{ desc = "Goto impl", mode = "n", lhs = "gi", rhs = "<cmd>lua vim.lsp.buf.implementation()<cr>" },
	{ desc = "Goto type", mode = "n", lhs = "gy", rhs = "<cmd>lua vim.lsp.buf.implementation()<cr>" },
	{ desc = "Goto type", mode = "n", lhs = "gr", rhs = "<cmd>lua vim.lsp.buf.references()<cr>" },

	{ desc = "Show signature", mode = "n", lhs = "gs", rhs = "<cmd>lua vim.lsp.buf.signature_help()<cr>" },
	{ desc = "Show diag", mode = "n", lhs = "gr", rhs = "<cmd>lua vim.diagnostic.open_float()<cr>" },
	{ desc = "Prev diag", mode = "n", lhs = "gr", rhs = "<cmd>lua vim.diagnostic.goto_prev()<cr>" },
	{ desc = "Next diag", mode = "n", lhs = "gr", rhs = "<cmd>lua vim.diagnostic.goto_next()<cr>" },

	{ desc = "Rename", mode = "n", lhs = "<F2>", rhs = "<cmd>lua vim.lsp.buf.rename()<cr>" },
	{ desc = "Format file", mode = "n", lhs = "<F3>", rhs = "<cmd>lua vim.lsp.buf.format()<cr>" },
	{ desc = "Format selection", mode = "x", lhs = "<F3>", rhs = "<cmd>lua vim.lsp.buf.format()<cr>" },
	{ desc = "Code Action", mode = "n", lhs = "<F4>", rhs = "<cmd>lua vim.lsp.buf.code_action()<cr>" },
}

local comment_operator_keymaps = {
	line = "gc",
	block = "gb",
}

local comment_toggler_keymaps = {
	line = "gcc",
	block = "gbc",
}

local textobjects_select_keymaps = {
	["aa"] = "@parameter.outer",
	["ia"] = "@parameter.inner",
	["af"] = "@function.outer",
	["if"] = "@function.inner",
}

local textobjects_move_keymaps = {
	goto_next_start = {
		["]aa"] = "@parameter.outer",
		["]ia"] = "@parameter.inner",
		["]af"] = "@function.outer",
		["]if"] = "@function.inner",
	},
	goto_next_end = {
		["]aA"] = "@parameter.outer",
		["]iA"] = "@parameter.inner",
		["]aF"] = "@function.outer",
		["]iF"] = "@function.inner",
	},
	goto_previous_start = {
		["[aa"] = "@parameter.outer",
		["[ia"] = "@parameter.inner",
		["[af"] = "@function.outer",
		["[if"] = "@function.inner",
	},
	goto_previous_end = {
		["[aA"] = "@parameter.outer",
		["[iA"] = "@parameter.inner",
		["[aF"] = "@function.outer",
		["[iF"] = "@function.inner",
	},
}

local surround_keymaps = {
	normal = "ys",
	normal_cur = "yss",
	normal_line = "yS",
	normal_cur_line = "ySS",
	visual = "S",
	visual_line = "gS",
	change = "cs",
	change_line = "cS",
	delete = "ds",
	insert = false, -- "<C-g>s",
	insert_line = false, -- "<C-g>S"
}

local treesitter_languages = {
	"c",
	"cpp",
	"java",
	"go",
	"python",
	"ruby",
	"rust",
	"lua",
	"markdown",
	"yaml",
}

local lsp_languages = {
	"clangd",
	"jdtls",
	"gopls",
	"pylsp",
	"ruby_lsp",
	"rust_analyzer",
	"lua_ls",
}

local plugins = {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		lazy = false,
		cond = enable_ux_plugins,
		config = function()
			require("onedarkpro").setup()
			vim.o.laststatus = 3
			vim.cmd([[
				au TextYankPost * silent!lua require('vim.highlight').on_yank()
				colorscheme onedark
			]])
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { 
			"nvim-tree/nvim-web-devicons", 
			"linrongbin16/lsp-progress.nvim", 
		},
		lazy = false,
		cond = enable_ux_plugins,
		config = function()
			local lualine = require("lualine")
			lualine.setup({
				options = {
					theme = "onedark",
					globalstatus = true,
				},
				tabline = {
					lualine_a = { "filename" },
					lualine_c = {
						function() return require("lsp-progress").progress() end,
					},				
					lualine_z = {  "tabs", {
							function() return #vim.api.nvim_list_wins() > 1 and [[ window]] or [[]] end,
							color = { bg = "#de5d68", fg = "#101012" },
							separator = { left = "" },
							on_click = function() vim.cmd("close") end
						}, {
							function() return vim.fn.tabpagenr("$") > 1 and [[ tab]] or [[]] end,
							color = { bg = "#833b3b", fg = "#101012" },
							separator = { left = "" },
							on_click = function() vim.cmd("tabclose") end
						}
					}
				},
			})

			local lsp_progress = require("lsp-progress").setup()
			vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = "lualine_augroup",
				pattern = "LspProgressStatusUpdated",
				callback = require("lualine").refresh,
			})
		end
	},
	{
		"dstein64/nvim-scrollview",
		event = "VeryLazy",
		cond = enable_ux_plugins,
	},
	{
		"ojroques/nvim-osc52",
		lazy = false,
	},
	{
		"gbprod/cutlass.nvim",
		lazy = false,
		opts = {
			override_del = true,
		},
	},
	{
		"numtostr/comment.nvim",
		lazy = false,
		opts = {
			opleader = comment_operator_keymaps,
			toggler = comment_toggler_keymaps,
			mappings = { extra = false },
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {
			keymaps = surround_keymaps,
		},
	},
	{
		"giancarlo-misasi/keymap-menu.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		cond = enable_ux_plugins,
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
	{
		"octarect/telescope-menu.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		event = "VeryLazy",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = treesitter_languages,
				auto_install = true,
				indent = true,
				incremental_selection = false,
				highlight = { enable = true },
				textobjects = {
					swap = false,
					select = {
						enable = true,
						lookahead = true,
						include_surrounding_whitespace = true,
						keymaps = textobjects_select_keymaps,
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = textobjects_move_keymaps.goto_next_start,
						goto_next_end = textobjects_move_keymaps.goto_next_end,
						goto_previous_start = textobjects_move_keymaps.goto_previous_start,
						goto_previous_end = textobjects_move_keymaps.goto_previous_end,
						goto_next = {},
						goto_previous = {},
					},
				},
			})
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "repeat forward" })
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { desc = "repeat back" })
			-- Make builtin f, F, t, T also repeatable with ; and ,
			-- this was the default behavior before we allowed repeating moves above
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
	},
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
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()
			
			local mason = require("mason")
			mason.setup()

			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = lsp_languages,
				handlers = {
					function(server_name)
						require('lspconfig')[server_name].setup({})
					end,
				},
			})

			lsp_zero.on_attach(function(client, bufnr)
				for _, k in pairs(lsp_keymaps) do
					vim.keymap.set(k.mode, k.lhs, k.rhs, { desc = k.desc, buffer = bufnr })
				end
			end)
			-- lsp_zero.setup()

			-- local autocomplete_keymaps = {
			-- 	confirm = "<Tab>",
			-- 	previous = "<S-Tab>",
			-- 	move_up = "<Up>",
			-- 	move_down = "<Down>",
			-- 	toggle = "<C-Space>",
			-- }

			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()
			local km = autocomplete_keymaps;
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					[km.confirm] = cmp.mapping.confirm({select = false}),
					[km.complete] = cmp.mapping.confirm(),
					[km.move_up] = cmp.mapping.select_prev_item({behavior = 'select'}),
					[km.move_down] = cmp.mapping.select_next_item({behavior = 'select'}),
					[km.toggle] = cmp_action.toggle_completion(),
				}),
			})

			lsp_zero.setup()
		end
	},
}

local function setup_plugin_manager()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
	require("lazy").setup(plugins)
end

local function setup_options(options)
	for k, v in pairs(options) do
		local status, exception = pcall(function()
			vim.opt[k] = v
		end)
		if not status then
			print("failed to set opt " .. k .. ": " .. exception)
		end
	end
end

local function setup_globals(globals)
	for k, v in pairs(globals) do
		local status, exception = pcall(function()
			vim.g[k] = v
		end)
		if not status then
			print("failed to set global " .. k .. ": " .. exception)
		end
	end
end

local function setup_nops(nops)
	for _, r in pairs(nops) do
		vim.keymap.set("n", r.lhs, r.rhs, { silent = true, noremap = true, desc = "nop" })
	end
end

local function setup_keymaps(keymaps)
	for _, k in pairs(keymaps) do
		vim.keymap.set(k.mode, k.lhs, k.rhs, { desc = k.desc, silent = true, noremap = true })
	end
end

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

local function setup_clipboard()
	local copy = {
		osc52 = function(lines, _)
			require("osc52").copy(table.concat(lines, "\n"))
		end,
		wsl = "clip.exe",
	}

	local paste = {
		osc52 = function()
			return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
		end,
		wsl = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
	}

	local clipboards = {
		osc52 = {
			name = "osc52",
			copy = { ["+"] = copy.osc52, ["*"] = copy.osc52 },
			paste = { ["+"] = paste.osc52, ["*"] = paste.osc52 },
			cache_enabled = true,
		},
		wsl = {
			name = "wsl",
			copy = { ["+"] = copy.wsl, ["*"] = copy.wsl },
			paste = { ["+"] = paste.wsl, ["*"] = paste.wsl },
			cache_enabled = false,
		},
	}

	if vim.fn.has("wsl") then
		vim.g.clipboard = clipboards.wsl
	else
		vim.g.clipboard = clipboards.osc52
	end
end

vim.cmd([[
  augroup _general_settings
    au!
    au FileType qf,help,man,netrw,lspinfo nnoremap <silent> <buffer> q :close<CR>
  augroup end

  augroup _popup_menu
    aunmenu PopUp
    nnoremenu PopUp.Split\ Right      :SplitRight<CR>
    nnoremenu PopUp.Split\ Down       :SplitDown<CR>
    nnoremenu PopUp.New\ Tab          :NewTab<CR>
    anoremenu PopUp.-1-               <Nop>
    nnoremenu PopUp.Close\ Split      :q!<CR>
    nnoremenu PopUp.Close\ Tab        :CloseTab<CR>
  augroup end
]])

setup_plugin_manager()
setup_globals(globals)
setup_options(options)
setup_commands(commands)
setup_nops(nops)
setup_keymaps(keymaps)
setup_clipboard()
