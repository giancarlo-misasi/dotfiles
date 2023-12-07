local enable_ux_plugins = not vim.g.vscode

local options = {
  clipboard = 'unnamedplus',
  writebackup = false,
  swapfile = false,
  undofile = true,
  number = true,
  relativenumber = true,
  wrap = false,
  cursorline = true,
  termguicolors = true,
  signcolumn = 'yes',
  showmode = true,
  showcmd = true,
  ignorecase = true,
  smartcase = true,
  incsearch = true,
  hlsearch = true,
  inccommand = 'nosplit',
  tabstop = 2,
  softtabstop = -1,
  shiftwidth = 0,
  shiftround = true,
  expandtab = true,
  autoindent = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  mouse = 'a',
  mousemodel = 'popup',
  keymodel = 'startsel',
  backspace = 'indent,eol,start',
  whichwrap = 'b,s,<,>,[,]',
  completeopt = {'menu', 'menuone'}, -- autocomplete always select first item
  updatetime = 300, -- faster completion (4000ms default)
  pumheight = 6,
  fillchars = {
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft  = '┫',
    vertright = '┣',
    verthoriz = '╋',
  },
}

local globals = {
  mapleader = ' ',
  maplocalleader = ' ',
  loaded_python3_provider = 0,
  loaded_ruby_provider = 0,
  loaded_perl_provider = 0,
  loaded_node_provider = 0,
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,
}

local commands = {
  'command! NewTab tabnew',
  'command! CloseTab tabclose',
  'command! SplitRight vsplit',
  'command! SplitDown split',
  'command! FindFiles Telescope find_files',
  'command! LiveGrep Telescope live_grep',
  'command! OldFiles Telescope oldfiles',
  'command! SearchHistory Telescope search_history',
  'command! SetLanguage Telescope filetypes',
  'command! Registers Telescope registers',
  'command! Commands Telescope commands',
  'command! CommandHistory Telescope command_history',
  'command! Buffers Telescope buffers',
  'command! Actions Telescope menu action_menu',
  'command! GotoDeclaration lua vim.lsp.buf.declaration()',
  'command! GotoImplementation lua vim.lsp.buf.implementation()',
  'command! FindReferences lua vim.lsp.buf.references()',
  'command! FormatCode vim.lsp.buf.format()',
  'command! Hover lua vim.lsp.buf.hover()',
  'command! SignatureHelp lua vim.lsp.buf.signature_help()',
  'command! CodeActions lua vim.lsp.buf.code_action()',
  'command! Rename lua vim.lsp.buf.rename()',
  'command! Quit qa!',
}

local menus = {
  action_items = {
    {'New tab', 'NewTab'},
    {'Close tab', 'CloseTab'},
    {'Split right', 'SplitRight'},
    {'Split down', 'SplitDown'},
    {'Find files', 'FindFiles'},
    {'Live grep', 'LiveGrep'},
    {'Old files', 'OldFiles'},
    {'Search history', 'SearchHistory'},
    {'Set language', 'SetLanguage'},
    {'Registers', 'Registers'},
    {'Commands', 'Commands'},
    {'Command history', 'CommandHistory'},
    {'Buffers', 'Buffers'},
    {'Goto declaration', 'GotoDeclaration'},
    {'Goto implementation', 'GotoImplementation'},
    {'Find references', 'FindReferences'},
    {'Format code', 'FormatCode'},
    {'Hover', 'Hover'},
    {'Signature help', 'SignatureHelp'},
    {'Code actions', 'CodeActions'},
    {'Rename', 'Rename'},
    {'Quit', 'Quit'},
  },
}

local remaps = {
  { cmd = 'noremap', lhs = '<Leader>q', rhs = 'q' },
  { cmd = 'noremap', lhs = 'q', rhs = '<Nop>' },
  { cmd = 'noremap', lhs = 'u', rhs = '<Nop>' },
  { cmd = 'noremap', lhs = '<C-f>', rhs = '<Nop>' },
  { cmd = 'noremap', lhs = '<C-b>', rhs = '<Nop>' },
  { cmd = 'noremap', lhs = '<C-h>', rhs = '<Nop>' },
}

-- Modes
--   normal_mode = n
--   insert_mode = i
--   visual_mode = x
--   command_mode = c
local keymaps = {
  { desc = 'Select all',      mode = 'n', lhs = '<C-a>',      rhs = 'ggVG' },
  { desc = 'Select all',      mode = 'i', lhs = '<C-a>',      rhs = '<Esc>ggVG' },
  { desc = 'Select all',      mode = 'x', lhs = '<C-a>',      rhs = '<Esc>ggVG' },
  { desc = 'Copy',            mode = 'x', lhs = '<C-c>',      rhs = '"+y' },
  { desc = 'Cut',             mode = 'x', lhs = '<C-x>',      rhs = '"+x' },
  { desc = 'Paste',           mode = 'i', lhs = '<C-v>',      rhs = '"+gP' },
  { desc = 'Paste',           mode = 'c', lhs = '<C-v>',      rhs = '<C-r><C-r>+' },
  { desc = 'Paste register',  mode = 'n', lhs = '<C-p>',      rhs = '"' },
  { desc = 'Paste register',  mode = 'i', lhs = '<C-p>',      rhs = '<C-o>"' },
  { desc = 'Undo',            mode = 'n', lhs = '<C-z>',      rhs = 'u' },
  { desc = 'Undo',            mode = 'i', lhs = '<C-z>',      rhs = '<C-o>u' },
  { desc = 'Redo',            mode = 'i', lhs = '<C-r>',      rhs = '<C-o><C-r>' },
  { desc = 'Save',            mode = 'n', lhs = '<C-s>',      rhs = ':update<CR>' },
  { desc = 'Save',            mode = 'i', lhs = '<C-s>',      rhs = '<Esc>:update<CR>gi' },
  { desc = 'Save',            mode = 'x', lhs = '<C-s>',      rhs = '<C-c>:update<CR>' },
  { desc = 'Jump back',       mode = 'n', lhs = '<C-Left>',   rhs = 'b' },
  { desc = 'Jump back',       mode = 'i', lhs = '<C-Left>',   rhs = '<Esc>b' },
  { desc = 'Jump fwd',        mode = 'n', lhs = '<C-Right>',  rhs = 'w' },
  { desc = 'Jump fwd',        mode = 'i', lhs = '<C-Right>',  rhs = '<Esc>w' },
  { desc = 'Move text down',  mode = 'n', lhs = '<A-Down>',   rhs = ':m .+1<CR>==' },
  { desc = 'Move text up',    mode = 'n', lhs = '<A-Up>',     rhs = ':m .-2<CR>==' },
  { desc = 'Move text down',  mode = 'i', lhs = '<A-Down>',   rhs = '<Esc>:m .+1<CR>==gi' },
  { desc = 'Move text up',    mode = 'i', lhs = '<A-Up>',     rhs = '<Esc>:m .-2<CR>==gi' },
  { desc = 'Move text down',  mode = 'x', lhs = '<A-Down>',   rhs = ":m '>+1<CR>gv=gv" },
  { desc = 'Move text up',    mode = 'x', lhs = '<A-Up>',     rhs = ":m '<-2<CR>gv=gv" },
  { desc = 'Jump list bck',   mode = 'n', lhs = '<A-Left>',   rhs = '<C-o>' },
  { desc = 'Jump list fwd',   mode = 'n', lhs = '<A-Right>',  rhs = '<C-i>' },
  { desc = 'Indent',          mode = 'n', lhs = '<Tab>',      rhs = '>>' },
  { desc = 'Indent',          mode = 'x', lhs = '<Tab>',      rhs = '>gv' },
  { desc = 'Reverse indent',  mode = 'n', lhs = '<S-Tab>',    rhs = '<<' },
  { desc = 'Reverse indent',  mode = 'x', lhs = '<S-Tab>',    rhs = '<gv' },
  { desc = 'Reverse indent',  mode = 'i', lhs = '<S-Tab>',    rhs = '<C-D>' },
  { desc = 'Actions',         mode = 'n', lhs = '<F1>',       rhs = ':Actions<cr>' },
  { desc = 'Actions',         mode = 'x', lhs = '<F1>',       rhs = ':<C-U>:Actions<cr>' },
  { desc = 'Commands',        mode = 'n', lhs = '<F2>',       rhs = ':Commands<cr>' },
  { desc = 'Commands',        mode = 'x', lhs = '<F2>',       rhs = ':<C-U>Commands<cr>' },
}

local surround_keymaps = {
  insert = "<C-g>s",
  insert_line = "<C-g>S",
  normal = "ys",
  normal_cur = "yss",
  normal_line = "yS",
  normal_cur_line = "ySS",
  visual = "S",
  visual_line = "gS",
  delete = "ds",
  change = "cs",
  change_line = "cS",
}

local comment_togger_keymaps = {
  line = '<C-_>', -- vim sees <C-/> as <C-_>
  block = 'gbc',
}

local comment_opleader_keymaps = {
  line = '<C-_>',
  block = 'gb',
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

local external_commands = {
  find_command = {
    "rg",
    "--files",
    "--hidden",
    "--glob",
    "!**/.git/*"
  },
}

-- local lualine_opts = {
--   options = {
--     theme = 'onedark',
--     globalstatus = true,
--   },
--   winbar = {},
--   inactive_winbar = {},
--   tabline = {
--     lualine_a = {
--       { 'filename', icon = '', separator = { right = '' } }
--     },
--     lualine_z = {
--       'tabs',
--       {
--         function()
--           if #vim.api.nvim_list_wins() > 1 then
--             return [[ window]]
--           else
--             return [[]]
--           end
--         end,
--         color = { bg = '#de5d68', fg = '#101012' },
--         separator = { left = '' },
--         on_click = function() vim.cmd('close') end
--       },
--       {
--         function()
--           if vim.fn.tabpagenr("$") > 1 then
--             return [[ tab]]
--           else
--             return [[]]
--           end
--         end,
--         color = { bg = '#833b3b', fg = '#101012' },
--         separator = { left = '' },
--         on_click = function() vim.cmd('tabclose') end
--       },
--     }
--   },
--   sections = {
--     lualine_a = {
--       { 'mode', separator = { right = '' } }
--     },
--     lualine_x = {
--       'encoding',
--       'fileformat',
--       {
--         'filetype',
--         color = { fg = '#ABB2BF' },
--         separator = '',
--         on_click = function()
--           local builtin = require('telescope.builtin')
--           if builtin then
--             builtin.filetypes()
--           end
--         end,
--       },
--     },
--   },
--   inactive_sections = {},
-- }
-- {
--   'nvim-lualine/lualine.nvim',
--   opts = lualine_opts,
--   event = 'VeryLazy',
--   cond = enable_ux_plugins,
-- },

local treesitter_languages = {
  'make',
  'cmake',
  'c',
  'cpp',
  'go',
  'python',
  'ruby',
  'rust',
  'lua',
  'markdown',
  'yaml',
}

local plugins = {
  {
    'olimorris/onedarkpro.nvim', priority = 1000,
    cond = enable_ux_plugins,
  },
  {
    'lukas-reineke/indent-blankline.nvim', main = "ibl",
    event = 'VeryLazy',
    cond = enable_ux_plugins,
  },
  {
    'dstein64/nvim-scrollview',
    event = 'VeryLazy',
    cond = enable_ux_plugins,
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim', 'octarect/telescope-menu.nvim', 'nvim-telescope/telescope-fzf-native.nvim' },
    event = 'VeryLazy',
    cond = enable_ux_plugins,
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        pickers = {
          find_files = { find_command = external_commands.find_command },
        },
        extensions = {
          menu = {
            action_menu = { items = menus.action_items },
          }
        },
      })
      telescope.load_extension('menu')
      telescope.load_extension('fzf')
    end
  },
  {
    'ojroques/nvim-osc52',
    lazy = false,
  },
  {
    'gbprod/cutlass.nvim',
    lazy = false,
    opts = {
      override_del = true
    },
  },
  {
    'kylechui/nvim-surround', version = '*',
    lazy = false,
    opts = {
      keymaps = surround_keymaps,
    },
  },
  {
    'numtostr/comment.nvim',
    lazy = false,
    opts = {
      toggler = comment_togger_keymaps,
      opleader = comment_opleader_keymaps,
      mappings = {
        basic = true,
        extra = false,
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    lazy = false,
    config = function()
      local configs = require('nvim-treesitter.configs')
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
              ['@parameter.outer'] = 'v',   -- charwise
              ['@function.outer'] = 'V',    -- linewise
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
        }
      })
    end,
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
  require('lazy').setup(plugins)
end

local function setup_options(options)
  for k, v in pairs(options) do
    local status, exception = pcall(function()
      vim.opt[k] = v
    end)
    if not status then
      print('failed to set opt ' .. k .. ': ' .. exception)
    end
  end
end

local function setup_globals(globals)
  for k, v in pairs(globals) do
    local status, exception = pcall(function()
      vim.g[k] = v
    end)
    if not status then
      print('failed to set global ' .. k .. ': ' .. exception)
    end
  end
end

local function setup_remaps(remaps)
  for _, r in pairs(remaps) do
    vim.cmd(r.cmd .. ' ' .. r.lhs .. ' ' .. r.rhs)
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
      print('failed to set command ' .. cmd .. ': ' .. exception)
    end
  end
end

local function setup_clipboard()
  local copy = {
    osc52 = function(lines, _)
      require('osc52').copy(table.concat(lines, '\n'))
    end,
    wsl = 'clip.exe',
  }

  local paste = {
    osc52 = function()
      return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
    end,
    wsl = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  }

  local clipboards = {
    osc52 = {
      name = 'osc52',
      copy = { ['+'] = copy.osc52, ['*'] = copy.osc52 },
      paste = { ['+'] = paste.osc52, ['*'] = paste.osc52 },
      cache_enabled = true
    },
    wsl = {
      name = 'wsl',
      copy = { ['+'] = copy.wsl, ['*'] = copy.wsl },
      paste = { ['+'] = paste.wsl, ['*'] = paste.wsl },
      cache_enabled = false
    }
  }

  if vim.fn.has('wsl') then
    vim.g.clipboard = clipboards.wsl
  else
    vim.g.clipboard = clipboards.osc52
  end
end

local function setup_telescope()
  local telescope = require('telescope')
  if telescope then
    telescope.load_extension('menu')
    telescope.load_extension('fzf')
  end
end

local function setup_treesitter()
  local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
  if ts_repeat_move then
    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

    -- Make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
  end

  -- Folding
  vim.opt.foldcolumn = 'auto'
  vim.opt.foldlevel = 99
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

  -- Fold workaround for treesitter bug https://github.com/nvim-telescope/telescope.nvim/issues/699
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = { "*" },
      command = "normal zx",
  })
end

vim.cmd [[
  augroup _general_settings
    au!
    au FileType qf,help,man,netrw,lspinfo nnoremap <silent> <buffer> q :close<CR>
    au TextYankPost * silent!lua require('vim.highlight').on_yank()
    au BufWinEnter * :set formatoptions-=cro
  augroup end
]]

setup_options(options)
setup_globals(globals)
setup_commands(commands)
setup_remaps(remaps)
setup_keymaps(keymaps)
setup_plugin_manager()
setup_clipboard()
setup_treesitter()

if not vim.g.vscode then
  setup_telescope()
  vim.cmd('colorscheme onedark')
end
