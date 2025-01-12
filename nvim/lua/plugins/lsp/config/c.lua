-- lsp configuration are found by filetype, since c and cpp share, this file exists
-- just so that if we open a c file, it finds the same module
return require("plugins.lsp.cpp")
