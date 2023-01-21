local name = 'setup_lualine'
local utils = require('utils').start_script(name)

local m = require('lualine')

local function snippet_status_item()
    local luasnip = require('luasnip')
    if luasnip and luasnip.in_snippet() then
        return "SNIP"
    else
        return [[]]
    end
end

local function folders_item()
    return utils.cwd()
end

local function lsp_client_item()
    local client = vim.lsp.get_active_clients({ bufnr = 0 })[1]
    if client then
        return client.name
    else
        return [[]]
    end
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

local function change_folders()
    vim.cmd(':Texplore')
end

local function find_files()
    local builtin = require('telescope.builtin')
    if builtin then
        builtin.find_files({
            cwd = utils.cwd()
        })
    end
end

local function show_lsp_info()
    vim.cmd(':LspInfo')
end

local function set_file_type()
    local builtin = require('telescope.builtin')
    if builtin then
        builtin.filetypes()
    end
end

m.setup {
    options = {
        theme = 'onedark'
    },
    sections = {
        lualine_a = { 
            snippet_status_item, 
            'mode', 
        },
        lualine_b = { 
            { 'branch', on_click = show_git_branches }, 
            { 'diff', on_click = show_git_status }, 
            { 'diagnostics', on_click = show_diagnostics }, 
        },
        lualine_c = {
            { folders_item, color = { bg = '#2c323c' }, icons_enabled = true, icon = { '', color = { fg = '#E5C07B' } }, separator = { right = '' }, on_click = change_folders },
            { 'filename', icons_enabled = true, icon = { '', color = { fg = '#ABB2BF' } }, on_click = find_files },
            'location',
            'lsp_progress',
        },
        lualine_x = { 
            'encoding', 
            'fileformat', 
            { 'filetype', separator = { left = '' }, on_click = set_file_type }, 
            { lsp_client_item, color = { bg = '#C678DD', fg = '#282C34' }, separator = { left = '' }, on_click = show_lsp_info },
        }
    },
}

utils.end_script(name)
