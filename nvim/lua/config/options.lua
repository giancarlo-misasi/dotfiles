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
    updatetime = 300,                    -- faster completion (4000ms default)
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

local function setup_globals(opts)
    for k, v in pairs(opts) do
        local status, exception = pcall(function()
            vim.g[k] = v
        end)
        if not status then
            print("failed to set global " .. k .. ": " .. exception)
        end
    end
end

local function setup_options(opts)
    for k, v in pairs(opts) do
        local status, exception = pcall(function()
            vim.opt[k] = v
        end)
        if not status then
            print("failed to set opt " .. k .. ": " .. exception)
        end
    end
end

setup_globals(globals)
setup_options(options)
