local name = 'setup_lualine'
local utils = require('utils').start_script(name)

local m = require('lualine')
local colors = require('colors')

local function show_git_branches()
  local builtin = require('telescope.builtin')
  if builtin then
    builtin.git_branches({
      cwd = vim.fn.getcwd()
    })
  end
end

local function show_diagnostics()
  local trouble = require('trouble')
  if trouble then
    trouble.open("document_diagnostics")
  end
end

local function set_file_type()
  local builtin = require('telescope.builtin')
  if builtin then
    builtin.filetypes()
  end
end

local function show_lsp_info()
  vim.cmd(':LspInfo')
end

local function in_snippet_mode(luasnip)
  return luasnip.jumpable(1) or luasnip.jumpable(-1)
end

local function string_component(str, bg, fg, on_click) return {
    function() return str end,
    color = { bg = bg, fg = fg },
    separator = { right = '' },
    on_click = on_click,
  }
end

local function snippet_status()
  local luasnip = require('luasnip')
  if luasnip and in_snippet_mode(luasnip) then
    return [[]]
  else
    return [[]]
  end
end

local function snippet_status_component() return {
    snippet_status,
    color = { bg = '#E06C75', fg = '#282C34' },
  }
end

local function filetype_component() return {
    'filetype',
    color = { fg = '#ABB2BF' },
    separator = '',
    on_click = set_file_type,
  }
end

local function lsp_status()
  local client = vim.lsp.get_active_clients({ bufnr = 0 })[1]
  if client then
    return client.name
  else
    return 'no lsp'
  end
end

local function lsp_component() return {
    lsp_status,
    color = { fg = '#ABB2BF' },
    separator = '',
    on_click = show_lsp_info,
  }
end

local function tab_close_status()
  if vim.fn.tabpagenr("$") > 1 then
    return [[ tab]]
  else
    return [[]]
  end
end

local function tab_close() return {
  tab_close_status,
  color = { bg = colors.dark_red, fg = colors.black },
  separator = { left = '' },
  on_click = function() vim.cmd('tabclose') end
} end

local function window_close_status()
  if #vim.api.nvim_list_wins() > 1 then
    return [[ window]]
  else
    return [[]]
  end
end

local function window_close() return {
  window_close_status,
  color = { bg = colors.red, fg = colors.black },
  separator = { left = '' },
  on_click = function() vim.cmd('close') end
} end

local function git_branch() return {
  'branch',
  color = { bg = colors.red },
  separator = { right = '' },
  on_click = show_git_branches
} end

local function git_diff() return {
  function() return [[]] end,
  color = { bg = colors.cyan },
  separator = { right = '' },
  on_click = function() vim.cmd('GitDiff') end
} end

local tab_sections = {
  lualine_a = { { 'filename', icon = '', separator = { right = '' } }, git_diff() },
  lualine_z = {  'tabs', window_close(), tab_close() }
}

local statusline_sections = {
  lualine_a = { snippet_status_component(), { 'mode', separator = { right = '' } }, git_branch() },
  lualine_b = { { 'diagnostics', on_click = show_diagnostics }, 'diff' },
  lualine_x = { 'encoding', 'fileformat', filetype_component(), lsp_component() },
}

m.setup {
  options = {
    theme = 'onedark',
    disabled_filetypes = {
      winbar = { 'toggleterm' },
      statusline = { 'dapui_scopes', 'dapui_breakpoints', 'dapui_stacks', 'dapui_watches', 'dap-repl', 'dapui_console', },
    },
    globalstatus = true,
  },
  tabline = tab_sections,
  winbar = {},
  inactive_winbar = {},
  sections = statusline_sections,
  inactive_sections = statusline_sections,
}

utils.end_script(name)
