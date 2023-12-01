local name = 'setup_lualine'
local utils = require('utils').start_script(name)

local m = require('lualine')
local colors = require('colors')

local function set_file_type()
  local builtin = require('telescope.builtin')
  if builtin then
    builtin.filetypes()
  end
end

local function in_snippet_mode(luasnip)
  return luasnip.jumpable(1) or luasnip.jumpable(-1)
end

local function filetype_component() return {
    'filetype',
    color = { fg = '#ABB2BF' },
    separator = '',
    on_click = set_file_type,
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

local tab_sections = {
  lualine_a = { { 'filename', icon = '', separator = { right = '' } } },
  lualine_z = {  'tabs', window_close(), tab_close() }
}

local statusline_sections = {
  lualine_a = { { 'mode', separator = { right = '' } } },
  lualine_x = { 'encoding', 'fileformat', filetype_component() },
}

m.setup {
  options = {
    theme = 'onedark',
    globalstatus = true,
  },
  tabline = tab_sections,
  winbar = {},
  inactive_winbar = {},
  sections = statusline_sections,
  inactive_sections = statusline_sections,
}

utils.end_script(name)
