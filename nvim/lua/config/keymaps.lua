local M = {}

-- Modes
--   normal_mode = n
--   insert_mode = i
--   visual_mode = x
--   command_mode = c
M.nops = {
  { lhs = "q",     rhs = "<Nop>" }, -- I often hit q by accident and dont use macros
  { lhs = "s",     rhs = "<Nop>" }, -- Used for flash
  { lhs = "S",     rhs = "<Nop>" }, -- Used for flash
  { lhs = "r",     rhs = "<Nop>" }, -- Used for flash
  { lhs = "<C-z>", rhs = "<Nop>" }, -- Used this for undo
}

-- Note: All keymaps here use noremap=true so that we can map to things that I have no-opped
M.editing = {
  -- escape terminal
  { desc = "Escape terminal",     mode = "t", lhs = "<ESC>",            rhs = "<C-\\><C-n>" },
  -- clear highlighting on escape
  { desc = "Clear highlighting",  mode = "n", lhs = "<ESC>",            rhs = "<CMD>noh<CR><ESC>" },
  -- jump movement
  { desc = "Jump down & center",  mode = "n", lhs = "<C-d>",            rhs = "<C-d>zz" },
  { desc = "Jump up & center",    mode = "n", lhs = "<C-u>",            rhs = "<C-u>zz" },
  -- selection
  { desc = "Select all",          mode = "n", lhs = "<C-a>",            rhs = "ggVG" },
  { desc = "Select all",          mode = "i", lhs = "<C-a>",            rhs = "<ESC>ggVG" },
  { desc = "Select all",          mode = "x", lhs = "<C-a>",            rhs = "<ESC>ggVG" },
  -- undo / redo
  { desc = "Undo",                mode = "n", lhs = "<C-z>",            rhs = "u" },
  { desc = "Undo",                mode = "i", lhs = "<C-z>",            rhs = "<C-o>u" },
  { desc = "Undo",                mode = "x", lhs = "<C-z>",            rhs = "<ESC>u" },
  { desc = "Redo",                mode = "n", lhs = "<C-y>",            rhs = "<C-r>" },
  { desc = "Redo",                mode = "i", lhs = "<C-y>",            rhs = "<C-o><C-r>" },
  { desc = "Redo",                mode = "x", lhs = "<C-y>",            rhs = "<ESC><C-r>" },
  -- visual cut
  { desc = "Visual cut",          mode = "x", lhs = "<C-x>",            rhs = "d" },
  -- text movement
  { desc = "Move text down",      mode = "n", lhs = "<A-Down>",         rhs = "<CMD>m .+1<CR>==" },
  { desc = "Move text down",      mode = "i", lhs = "<A-Down>",         rhs = "<ESC><CMD>m .+1<CR>==gi" },
  { desc = "Move text down",      mode = "x", lhs = "<A-Down>",         rhs = ":m '>+1<CR>gv=gv" },
  { desc = "Move text up",        mode = "n", lhs = "<A-Up>",           rhs = "<CMD>m .-2<CR>==" },
  { desc = "Move text up",        mode = "i", lhs = "<A-Up>",           rhs = "<ESC><CMD>m .-2<CR>==gi" },
  { desc = "Move text up",        mode = "x", lhs = "<A-Up>",           rhs = ":m '<-2<CR>gv=gv" },
  { desc = "Indent",              mode = "x", lhs = "<Tab>",            rhs = ">gv" },
  { desc = "Reverse indent",      mode = "i", lhs = "<S-Tab>",          rhs = "<C-D>" },
  { desc = "Reverse indent",      mode = "x", lhs = "<S-Tab>",          rhs = "<gv" },
  -- tab movement
  { desc = "Move to prev tab",    mode = "n", lhs = "<C-Left>",         rhs = "gt" },
  { desc = "Move to next tab",    mode = "n", lhs = "<C-Right>",        rhs = "gT" },
  -- split movement
  { desc = "Move to upper split", mode = "n", lhs = "<leader><Up>",     rhs = "<C-w>k" },
  { desc = "Move to lower split", mode = "n", lhs = "<leader><Down>",   rhs = "<C-w>j" },
  { desc = "Move to left split",  mode = "n", lhs = "<leader><Left>",   rhs = "<C-w>h" },
  { desc = "Move to right split", mode = "n", lhs = "<leader><Right>",  rhs = "<C-w>l" },
  { desc = "Cycle split mode",    mode = "n", lhs = "<leader><leader>", rhs = "<CMD>CycleSplitMode<CR>" },
  -- commands
  { desc = "Actions",             mode = "n", lhs = "<F1>",             rhs = "<CMD>Actions<CR>" },
  { desc = "LiveGrep",            mode = "n", lhs = "<leader>g",        rhs = "<CMD>LiveGrep<CR>" },
  { desc = "FindFiles",           mode = "n", lhs = "<leader>f",        rhs = "<CMD>FindFiles<CR>" },
  { desc = "FileTree",            mode = "n", lhs = "<leader>t",        rhs = "<CMD>FileTree<CR>" },
  { desc = "Replace text",        mode = "n", lhs = "<leader>r",        rhs = "<CMD>ReplaceText<CR>" },
  { desc = "Toggle lsp",          mode = "n", lhs = "<F9>",             rhs = "<CMD>ToggleLsp<CR>" },
}

M.repeat_move = {
  repeat_forward = ";",
  repeat_backward = ",",
  move_forward = "]",
  move_backward = "[",
  jump_list_forward = "]]",
  jump_list_backward = "[[",
  diagnostic_keys = {
    { key = "d", severity = nil },
    { key = "e", severity = "error" },
    { key = "w", severity = "warn" },
    { key = "i", severity = "info" },
    { key = "h", severity = "hint" },
  },
}

M.autocomplete = {
  confirm = "<CR>",
  complete = "<Tab>",
  move_up = "<Up>",
  move_down = "<Down>",
  docs_up = "<C-u>",
  docs_down = "<C-d>",
  toggle = "<C-Space>",
  hide = "<C-c>",
}

M.surround = {
  normal = "gsy",
  normal_cur = "gsyy",
  change = "gsc",
  delete = "gsd",
  insert = false,
  insert_line = false,
  visual = false,
  visual_line = false,
  normal_line = false,
  normal_cur_line = false,
  change_line = false,
}

M.comment_operator = {
  line = "gc",
  block = "gb",
}

M.comment_toggler = {
  line = "gcc",
  block = "gbc",
}

M.flash = {
  { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,                                   desc = "Flash Jump" },
  { "S", mode = { "n" },           function() require("flash").treesitter({ jump = { pos = "start" } }) end, desc = "Flash Treesitter" },
  { "S", mode = { "x", "o" },      function() require("flash").treesitter() end,                             desc = "Flash Treesitter (Visual)" },
  { "r", mode = { "o" },           function() require("flash").remote() end,                                 desc = "Remote Flash" },
}

M.textobjects_select = {
  ["aa"] = "@parameter.outer",
  ["ia"] = "@parameter.inner",
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ab"] = "@block.outer",
  ["ib"] = "@block.inner",
}

M.lsp = {
  { desc = "Goto defn",   mode = "n", lhs = "gd",  rhs = "<CMD>LspDefn<CR>" },
  { desc = "Goto decl",   mode = "n", lhs = "gD",  rhs = "<CMD>LspDecl<CR>" },
  { desc = "Goto type",   mode = "n", lhs = "gy",  rhs = "<CMD>LspTypeDef<CR>" },
  { desc = "Format code", mode = "n", lhs = "grf", rhs = "<CMD>FormatCode<CR>" },

  -- https://neovim.io/doc/user/lsp.html#lsp-defaults
  -- rename           grn
  -- code actions     gra
  -- references       grr
  -- implementation   gri
  -- hover            K
  -- signature help   CTRL-S
}

return M
