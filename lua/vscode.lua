local name = 'vscode'
local utils = require('utils').start_script(name)

local M = {}

-- extract the label from an option
local function format_option(option)
    return option.label
end

-- extract value from select, or if new entry, just return the value
local function select_option(option, callback)
    if option == nil then
        return
    elseif option["value"] ~= nil then
        callback(option.value)
    else
        callback(option)
    end
end

-- uses vscode option format to create select or input prompts
local function prompt(options, prompt, valueCallback)
    if options ~= nil then
        vim.ui.select(options, { prompt = prompt, format_item = format_option }, function(option)
            select_option(option, valueCallback)
        end)
    else
        vim.ui.input({ prompt = prompt }, function(option)
            select_option(option, valueCallback)
        end)
    end
end

-- for calling multiple prompts in sequence (they are async, so need callback chaining)
local function prompt_chain(inputs, n, i, results, doneCallback)
    if i > n then return end
    local input = inputs[i]
    local options = input["options"]
    local description = input["description"]
    prompt(options, description, function(value)
        table.insert(results, { ["id"] = input.id, ["value"] = value })
        if i < n then
            prompt_chain(inputs, n, i + 1, results, doneCallback)
        else
            doneCallback(results)
        end
    end)
end

local function filter_inputs_to_command(cmd, inputs)
    local results = {}
    for _, input in pairs(inputs) do
        if string.find(cmd, input.id) then
            table.insert(results, input)
        end
    end
    return results
end

local function populate_command_with_inputs(cmd, inputs)
    for _, input in pairs(inputs) do
        cmd = string.gsub(cmd, "${input:" .. input.id .. "}", input.value)
    end
    return cmd
end

-- sample option json
-- {
--     "id": "input1",
--     "type": "pickString",
--     "description": "prompt for input1",
--     "options": [ 
--         { "label": "option1", "value": "value for option1" },
--         { "label": "option2", "value": "value for option2" },
--     ]
-- },
-- {
--     "id": "input2",
--     "type": "promptString",
--     "description": "prompt for input2"
-- }

local function process_vscode_inputs(inputs, inputsReadyCallback)
    local n = table.getn(inputs)
    if n < 1 then
        inputsReadyCallback({})
    else
        prompt_chain(inputs, n, 1, {}, inputsReadyCallback)
    end
end

-- sample task json
-- {
--     "label": "build",
--     "type": "shell",
--     "command": "make",
--     "args": [ "my_make_target" ]
-- },
-- note: for now, only support shell tasks

local function process_vscode_tasks(tasks, taskSelectedCallback)
    local options = {}
    for _, task in pairs(tasks) do
        local option = {}
        option["label"] = task.label
        option["value"] = task.command .. ' ' .. table.concat(task.args, ' ')
        table.insert(options, option)
    end
    prompt(options, "Select a task: ", taskSelectedCallback)
end

-- for replaying past requests
local cmd_history = {}

local function get_task_history()
    local result = {}
    for k,v in pairs(cmd_history) do
        local option = {}
        option["label"] = k
        option["value"] = k
        table.insert(result, option)
    end
    return result
end

-- requires toggleterm at this time (could run with os.execute, but hard to debug)
local function run_cmd(cmd)
    cmd_history[cmd] = 1
    vim.cmd('TermExec cmd="' .. cmd .. '"')
end

-- vscode supports keyword replacement
-- for now support the following: 
--   ${workspaceFolder}
--   ${input:yourCustomInput}

-- launches a task not yet in the history
M.launch_new_task = function()
    local path = vim.fn.getcwd() .."/.vscode/tasks.json"
    if not utils.path_exists(path) then return end

    local ok, json = utils.parse_json(path)
    if not ok then return end

    process_vscode_tasks(json["tasks"], function(command)
        local cmd = string.gsub(command, "${workspaceFolder}", utils.cwd())
        print('a: ' .. cmd)

        local filtered_inputs = filter_inputs_to_command(cmd, json["inputs"])
        print('b: ' .. vim.inspect(filtered_inputs))

        process_vscode_inputs(filtered_inputs, function(inputs)
            cmd = populate_command_with_inputs(cmd, inputs)
            print('c' .. cmd)

            run_cmd(cmd)
        end)
    end)
end

-- launches an existing task
M.launch_old_task = function()
    local history = get_task_history()
    if table.getn(history) > 0 then
        prompt(history, "Would you like to re-run a task?", function(cmd)
            run_cmd(cmd)
        end)
    end
end

utils.end_script(name)
return M
