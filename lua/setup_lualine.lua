local name = 'setup_lualine'
local utils = require('utils').start_script(name)

local m = require('lualine')
local colors = require('colors')
local color_cycle = { colors.light_grey, colors.fg }
local color_count = table.getn(color_cycle)

local function file_browser()
  vim.cmd(':Telescope file_browser')
end

local function show_git_branches()
  local builtin = require('telescope.builtin')
  if builtin then
    builtin.git_branches({
      cwd = require('telescope.utils').buffer_dir()
    })
  end
end

local function show_git_status()
  local builtin = require('telescope.builtin')
  if builtin then
    builtin.git_status({
      cwd = require('telescope.utils').buffer_dir()
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

local function tabline_component()
  local result = { string_component('', colors.yellow) }

  -- Add an entry per folder
  local ci = 0
  local cwd = utils.cwd()
  for d in cwd:gmatch("([^/]+)") do
    table.insert(result, string_component(d, color_cycle[ci + 1], colors.black))
    ci = (ci + 1) % (color_count)
  end

  -- Add git components
  table.insert(result,
    { 'branch', color = { bg = colors.red }, separator = { right = '' }, on_click = show_git_branches })

  return result
end

local tab_sections = {
  lualine_a = tabline_component(),
  lualine_b = { string_component(' diff', colors.bg3, colors.white, show_git_status) },
  lualine_z = { 'tabs' }
}

local winbar_sections = {
  lualine_a = {
    { 'filename', icon = '', separator = { right = ' ' } }
  }
}

local statusline_sections = {
  lualine_a = { snippet_status_component(), 'mode' },
  lualine_b = { { 'diagnostics', on_click = show_diagnostics }, 'diff' },
  lualine_x = { 'encoding', 'fileformat', filetype_component(), lsp_component() },
}

m.setup {
  options = {
    theme = 'onedark'
  },
  tabline = tab_sections,
  winbar = winbar_sections,
  inactive_winbar = winbar_sections,
  sections = statusline_sections,
  inactive_sections = statusline_sections,
}

utils.end_script(name)
