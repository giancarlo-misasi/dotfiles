local M = {}

-- Modes
--   normal_mode = n
--   insert_mode = i
--   visual_mode = x
--   command_mode = c

M.nops = {
    { lhs = "q", rhs = "<Nop>" },
}

-- Note: All keymaps here use noremap=true so that we can map to things that I have no-opped
M.editing = {
    { desc = "Select all",         mode = "n", lhs = "<C-a>",     rhs = "ggVG" },
    { desc = "Select all",         mode = "i", lhs = "<C-a>",     rhs = "<Esc>ggVG" },
    { desc = "Select all",         mode = "x", lhs = "<C-a>",     rhs = "<Esc>ggVG" },
    { desc = "Copy",               mode = "x", lhs = "<C-c>",     rhs = '"+y' },
    { desc = "Cut",                mode = "x", lhs = "<C-x>",     rhs = '"+x' },
    { desc = "Paste",              mode = "i", lhs = "<C-v>",     rhs = '"+gP' },
    { desc = "Paste",              mode = "c", lhs = "<C-v>",     rhs = "<C-r><C-r>+" },
    { desc = "Undo",               mode = "n", lhs = "<C-z>",     rhs = "u" },
    { desc = "Undo",               mode = "i", lhs = "<C-z>",     rhs = "<C-o>u" },
    { desc = "Undo",               mode = "x", lhs = "<C-z>",     rhs = "<Esc>u" },
    { desc = "Redo",               mode = "n", lhs = "<C-y>",     rhs = "<C-r>" },
    { desc = "Redo",               mode = "i", lhs = "<C-y>",     rhs = "<C-o><C-r>" },
    { desc = "Redo",               mode = "x", lhs = "<C-y>",     rhs = "<Esc><C-r>" },
    { desc = "Save",               mode = "n", lhs = "<C-s>",     rhs = ":update<CR>" },
    { desc = "Save",               mode = "i", lhs = "<C-s>",     rhs = "<Esc>:update<CR>gi" },
    { desc = "Save",               mode = "x", lhs = "<C-s>",     rhs = "<Esc>:update<CR>" },
    { desc = "Jump back",          mode = "i", lhs = "<C-Left>",  rhs = "<Esc>b" },
    { desc = "Jump forward",       mode = "i", lhs = "<C-Right>", rhs = "<Esc>w" },
    { desc = "Move text down",     mode = "n", lhs = "<A-Down>",  rhs = ":m .+1<CR>==" },
    { desc = "Move text down",     mode = "i", lhs = "<A-Down>",  rhs = "<Esc>:m .+1<CR>==gi" },
    { desc = "Move text down",     mode = "x", lhs = "<A-Down>",  rhs = ":m '>+1<CR>gv=gv" },
    { desc = "Move text up",       mode = "n", lhs = "<A-Up>",    rhs = ":m .-2<CR>==" },
    { desc = "Move text up",       mode = "i", lhs = "<A-Up>",    rhs = "<Esc>:m .-2<CR>==gi" },
    { desc = "Move text up",       mode = "x", lhs = "<A-Up>",    rhs = ":m '<-2<CR>gv=gv" },
    { desc = "Jump list backward", mode = "n", lhs = "<A-Left>",  rhs = "<C-o>" },
    { desc = "Jump list forward",  mode = "n", lhs = "<A-Right>", rhs = "<C-i>" },
    { desc = "Indent",             mode = "n", lhs = "<Tab>",     rhs = ">>" },
    { desc = "Indent",             mode = "x", lhs = "<Tab>",     rhs = ">gv" },
    { desc = "Reverse indent",     mode = "n", lhs = "<S-Tab>",   rhs = "<<" },
    { desc = "Reverse indent",     mode = "i", lhs = "<S-Tab>",   rhs = "<C-D>" },
    { desc = "Reverse indent",     mode = "x", lhs = "<S-Tab>",   rhs = "<gv" },
    { desc = "Actions",            mode = "n", lhs = "<F1>",      rhs = ":Actions<cr>" },
}

M.autocomplete = {
    confirm = "<CR>",
    complete = "<Tab>",
    move_up = "<Up>",
    move_down = "<Down>",
    toggle = "<C-Space>",
}

M.surround = {
    normal = "ys",
    normal_cur = "yss",
    normal_line = "yS",
    normal_cur_line = "ySS",
    visual = "S",
    visual_line = "gS",
    change = "cs",
    change_line = "cS",
    delete = "ds",
    insert = false,      -- "<C-g>s",
    insert_line = false, -- "<C-g>S"
}

M.comment_operator = {
    line = "gc",
    block = "gb",
}

M.comment_toggler = {
    line = "gcc",
    block = "gbc",
}

M.textobjects_select = {
    ["aa"] = "@parameter.outer",
    ["ia"] = "@parameter.inner",
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
}

M.textobjects_move = {
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

M.lsp = {
    { desc = "Hover",            mode = "n", lhs = "K",    rhs = "<cmd>lua vim.lsp.buf.hover()<cr>" },
    { desc = "Show references",  mode = "n", lhs = "gr",   rhs = "<cmd>lua vim.lsp.buf.references()<cr>" },
    { desc = "Show signature",   mode = "n", lhs = "gs",   rhs = "<cmd>lua vim.lsp.buf.signature_help()<cr>" },
    { desc = "Goto defn",        mode = "n", lhs = "gd",   rhs = "<cmd>lua vim.lsp.buf.definition()<cr>" },
    { desc = "Goto decl",        mode = "n", lhs = "gD",   rhs = "<cmd>lua vim.lsp.buf.declaration()<cr>" },
    { desc = "Goto impl",        mode = "n", lhs = "gi",   rhs = "<cmd>lua vim.lsp.buf.implementation()<cr>" },
    { desc = "Goto type",        mode = "n", lhs = "gy",   rhs = "<cmd>lua vim.lsp.buf.type_definition()<cr>" },
}

return M
