local M = {}

M.action_items = {
    { "Install treesitter languages", "TSUpdate" },
    { "Install lsp tools",            "MasonToolsUpdate" },

    { "Split right",                  "SplitRight" },
    { "Split down",                   "SplitDown" },
    { "Close split",                  "CloseSplit" },
    { "New tab",                      "NewTab" },
    { "Load cwd to buffers",          "LoadCwdToBuffers"},
    { "Close tab",                    "CloseTab" },
    { "Close other buffers",          "CloseOtherBuffers"},

    { "Terminal right",               "TerminalRight" },
    { "Terminal down",                "TerminalDown" },
    { "Git",                          "GitLeft" },

    { "File tree",                    "FileTree" },
    { "Find files",                   "FindFiles" },
    { "Live grep",                    "LiveGrep" },
    { "Recent files",                 "RecentFiles" },
    { "Search history",               "SearchHistory" },
    { "Set language",                 "SetLanguage" },
    { "Registers",                    "Registers" },
    { "Commands",                     "Commands" },
    { "Command history",              "CommandHistory" },
    { "Diagnostics",                  "Diagnostics" },
    { "Buffers",                      "Buffers" },

    { "Start lsp",                    "StartLsp" },
    { "Stop lsp",                     "LspStop" },
    { "Show lsp status",              "LspInfo" },
    { "Rename",                       "Rename" },
    { "Format code",                  "FormatCode" },
    { "Format buffers",               "FormatBuffers" },
    { "Code actions",                 "CodeActions" },
    { "Hover",                        "Hover" },
    { "Show references",              "ShowReferences" },
    { "Show signature",               "ShowSignature" },
    { "Goto definition",              "GotoDefinition" },
    { "Goto declaration",             "GotoDeclaration" },
    { "Goto implementation",          "GotoImplementation" },
    { "Goto type",                    "GotoType" },
    { "Debug",                        "Debug" },

    { "To upper case",                "ToUpperCase" },
    { "To lower case",                "ToLowerCase" },
    { "To snake case",                "ToSnakeCase" },
    { "To dash case",                 "ToDashCase" },
    { "To constant case",             "ToConstantCase" },
    { "To dot case",                  "ToDotCase" },
    { "To comma case",                "ToCommaCase" },
    { "To phrase case",               "ToPhraseCase" },
    { "To camel case",                "ToCamelCase" },
    { "To pascal case",               "ToPascalCase" },
    { "To title case",                "ToTitleCase" },
    { "To path case",                 "ToPathCase" },

    { "Quit",                         "Quit" },
}

return M
