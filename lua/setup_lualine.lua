local name = 'setup_lualine'
local utils = require('utils').start_script(name)

local m = require('lualine')

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

local function snippet_status_icon()
    local luasnip = require('luasnip')
    if luasnip and in_snippet_mode(luasnip) then
        return [[]]
    else
        return [[]]
    end
end

local function snippet_status_component() return {
    snippet_status_icon,
    color = { bg = '#E06C75', fg = '#282C34' },
} end

local function current_folder_component() return {
    utils.cwd,
    color = { bg = '#2c323c' },
    icons_enabled = true,
    icon = { '', color = { fg = '#E5C07B' } },
    separator = { right = '' },
    on_click = file_browser
} end

local function git_status_icon()
    return [[]]
end

local function git_status_component() return {
    git_status_icon,
    color = { bg = '#61AFEF', fg = '#282C34' },
    separator = { right = '' },
    on_click = show_git_status
} end

local function filetype_component() return {
  'filetype',
  color = { fg = '#ABB2BF' },
  separator = '',
  on_click = set_file_type,
} end

local function lsp_status_icon()
    local client = vim.lsp.get_active_clients({ bufnr = 0 })[1]
    if client then
        return [[]]
    else
        return [[]]
    end
end

local function lsp_component() return {
    lsp_status_icon,
    color = { bg = '#56B6C2', fg = '#282C34' },
    separator = { left = '' },
    on_click = show_lsp_info,
} end

m.setup {
    options = {
        theme = 'onedark'
    },
    sections = {
        lualine_a = { snippet_status_component(), 'mode', },
        lualine_b = {
          current_folder_component(),
          git_status_component(),
          { 'branch', on_click = show_git_branches },
          { 'diagnostics', on_click = show_diagnostics },
          { 'diff' },
        },
        lualine_c = { 'lsp_progress' },
        lualine_x = { 'encoding', 'fileformat', filetype_component(), lsp_component() },
    },
}

utils.end_script(name)
