local M = {}

local mode = 0
local modes = { "autoresize", "maximise", "equalise" }

M.refresh = function()
  require("focus").resize(modes[mode + 1])
end

M.cycle = function()
  mode = (mode + 1) % #modes
  M.refresh()
end

return M
