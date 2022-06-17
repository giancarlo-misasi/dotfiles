local name = 'icons'
local utils = require('utils').start_script(name)
local M = {}

M.sign_icons = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
  Okay = "✅",
}

M.kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

utils.end_script(name)
return M
