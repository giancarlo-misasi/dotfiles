-- NOTE: Actions with a command name are automatically registered

--    Description                     Command name      Action function
return {
  { "Install mason tools",          "",              function() vim.cmd("MasonToolsUpdate") end },
  { "Install treesitter languages", "",              function() vim.cmd("TSUpdate") end },

  { "Actions",                      "Actions",       function() require("telescope").extensions.menu.action_menu {} end },
  { "File tree",                    "FileTree",      function() vim.cmd("Oil .") end },
  { "Terminal right",               "",              function() vim.cmd("vsplit | term") end },
  { "Terminal down",                "",              function() vim.cmd("split | term") end },
  { "Git",                          "Git",           function() vim.cmd("term lazygit") end },
  { "Notifications",                "",              function() vim.cmd("Noice all") end },
  { "Start leetcode",               "",              function() vim.cmd("StartLeet") end },

  { "Split right",                  "",              function() vim.cmd("vsplit") end },
  { "Split down",                   "",              function() vim.cmd("split") end },
  { "Close split",                  "",              function() vim.cmd("q!") end },
  { "New tab",                      "",              function() vim.cmd("tabnew") end },
  { "Close tab",                    "",              function() vim.cmd("tabclose") end },
  { "Load cwd to buffers",          "",              function() vim.cmd("args **/*") end },
  { "Close other buffers",          "",              function() vim.cmd("w|%bd|e#") end },

  { "Find text",                    "FindText",      function() require("telescope.builtin").current_buffer_fuzzy_find { default_text = vim.fn.expand("<cword>") } end },
  { "Find files",                   "FindFiles",     function() require("telescope.builtin").find_files {} end },
  { "Live grep",                    "LiveGrep",      function() require("telescope").extensions.live_grep_args.live_grep_args {} end }, -- require("telescope.builtin").live_grep {}
  { "Recent files",                 "",              function() require("telescope.builtin").oldfiles {} end },
  { "Buffers",                      "Buffers",       function() require("telescope.builtin").buffers {} end },
  { "Commands",                     "",              function() require("telescope.builtin").commands {} end },
  { "Diagnostics",                  "Diagnostics",   function() require("telescope.builtin").diagnostics {} end },
  { "Flash jump",                   "FlashJump",     function() require("flash").jump({ search = { mode = "fuzzy" } }) end },
  { "Flash remote",                 "FlashRemote",   function() require("flash").remote() end },
  { "Flash toggle",                 "FlashToggle",   function() require("flash").toggle() end },
  { "Replace text",                 "ReplaceText",   function() require("rip-substitute").sub() end },

  { "Set language",                 "",              function() require("telescope.builtin").filetypes {} end },
  { "Toggle word wrap",             "",              function() vim.cmd("set wrap!") end },
  { "To upper case",                "",              function() require("textcase").current_word("to_upper_case") end },
  { "To lower case",                "",              function() require("textcase").current_word("to_lower_case") end },
  { "To snake case",                "",              function() require("textcase").current_word("to_snake_case") end },
  { "To dash case",                 "",              function() require("textcase").current_word("to_dash_case") end },
  { "To constant case",             "",              function() require("textcase").current_word("to_constant_case") end },
  { "To dot case",                  "",              function() require("textcase").current_word("to_dot_case") end },
  { "To comma case",                "",              function() require("textcase").current_word("to_comma_case") end },
  { "To phrase case",               "",              function() require("textcase").current_word("to_phrase_case") end },
  { "To camel case",                "",              function() require("textcase").current_word("to_camel_case") end },
  { "To pascal case",               "",              function() require("textcase").current_word("to_pascal_case") end },
  { "To title case",                "",              function() require("textcase").current_word("to_title_case") end },
  { "To path case",                 "",              function() require("textcase").current_word("to_path_case") end },

  { "Toggle lsp",                   "ToggleLsp",     function() require("modules.lsp").toggle() end },
  { "Show lsp status",              "",              function() vim.cmd("LspInfo") end },
  { "Rename",                       "",              function() vim.lsp.buf.rename() end },
  { "Format code",                  "FormatCode",    function() vim.lsp.buf.format() end },
  { "Format buffers",               "",              function() vim.cmd("bufdo FormatCode") end },
  { "Code actions",                 "CodeActions",   function() vim.lsp.buf.code_action() end },
  { "Hover",                        "LspHover",      function() vim.lsp.buf.hover() end },
  { "Show references",              "LspRef",        function() vim.lsp.buf.references() end },
  { "Show signature",               "LspSig",        function() vim.lsp.buf.signature_help() end },
  { "Goto definition",              "LspDefn",       function() vim.lsp.buf.definition() end },
  { "Goto declaration",             "LspDecl",       function() vim.lsp.buf.declaration() end },
  { "Goto implementation",          "LspImpl",       function() vim.lsp.buf.implementation() end },
  { "Goto type",                    "LspTypeDef",    function() vim.lsp.buf.type_definition() end },
  { "Debug",                        "StartDebug",    function() require("modules.dap").start() end },
  { "Toggle debug ui",              "ToggleDebugUi", function() require("modules.dap").toggle_ui() end },

  { "Quit",                         "",              function() vim.cmd("qa!") end },
}

