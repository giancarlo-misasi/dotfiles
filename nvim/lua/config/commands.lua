local actions = require("config.actions")

-- register entries with command names as commands
for _, action in ipairs(actions) do
  if action[2] ~= "" then
    vim.api.nvim_create_user_command(action[2], action[3], {})
  end
end

