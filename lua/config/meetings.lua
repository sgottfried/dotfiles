-- [nfnl] fnl/config/meetings.fnl
local M = {}
local meetings_dir = vim.fn.expand("~/meetings")
M["get-date-paths"] = function()
  local year = os.date("%Y")
  local month = os.date("%m-%B")
  local date = os.date("%Y-%m-%d")
  local time = os.date("%H%M")
  return {year = year, month = month, date = date, time = time, ["month-dir"] = (meetings_dir .. "/" .. year .. "/" .. month)}
end
M["ensure-dir"] = function(path)
  return vim.fn.mkdir(path, "p")
end
M["load-template"] = function(template_name)
  local template_path = (meetings_dir .. "/templates/" .. template_name .. ".md")
  local file = io.open(template_path, "r")
  if file then
    local content = file:read("*a")
    file:close()
    return content
  else
    return ""
  end
end
M["process-template"] = function(content)
  return string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(content, "{{date}}", os.date("%Y-%m-%d")), "{{time}}", os.date("%H:%M")), "{{datetime}}", os.date("%Y-%m-%d %H:%M")), "{{day}}", os.date("%A")), "{{week}}", os.date("%W"))
end
M.create = function(template_name, title)
  local paths = M["get-date-paths"]()
  local safe_title = string.gsub(string.gsub(string.lower(title), "%s+", "-"), "[^%w%-]", "")
  local filename = (paths.date .. "_" .. paths.time .. "_" .. safe_title .. ".md")
  local filepath = (paths["month-dir"] .. "/" .. filename)
  M["ensure-dir"](paths["month-dir"])
  vim.cmd(("edit " .. filepath))
  do
    local template = M["load-template"](template_name)
    local content = M["process-template"](template)
    if (content ~= "") then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n"))
    else
    end
  end
  vim.cmd("normal! gg")
  vim.cmd(("normal! /" .. (title or "# ")))
  vim.cmd("nohlsearch")
  vim.cmd("normal! $")
  return vim.cmd("startinsert")
end
M.search = function()
  local snacks = require("snacks")
  return snacks.picker.grep({cwd = meetings_dir})
end
M.find = function()
  local snacks = require("snacks")
  return snacks.picker.files({cwd = meetings_dir})
end
M.today = function()
  local paths = M["get-date-paths"]()
  local today_pattern = (paths["month-dir"] .. "/" .. paths.date .. "_*.md")
  local files = vim.fn.glob(today_pattern, true, true)
  if (#files > 0) then
    for _, file in ipairs(files) do
      vim.cmd(("edit " .. file))
    end
    return nil
  else
    return print("No meetings today")
  end
end
M["extract-actions"] = function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local actions = {}
  for _, line in ipairs(lines) do
    if line:match("^%s*%- %[ %]") then
      table.insert(actions, line)
    else
    end
  end
  if (#actions > 0) then
    vim.cmd("new")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.list_extend({"# Action Items", ""}, actions))
    return vim.bo.buftype("nofile")
  else
    return print("No action items found")
  end
end
local recurring_dir = (meetings_dir .. "/recurring")
M["load-recurring-config"] = function(name)
  local config_path = (recurring_dir .. "/" .. name .. ".json")
  local file = io.open(config_path, "r")
  if file then
    local content = file:read("*a")
    local _ = file:close()
    return vim.json.decode(content)
  else
    return nil
  end
end
M["save-recurring-config"] = function(name, config)
  M["ensure-dir"](recurring_dir)
  local config_path = (recurring_dir .. "/" .. name .. ".json")
  local file = io.open(config_path, "w")
  local json = vim.json.encode(config)
  file:write(json)
  return file:close()
end
M["list-recurring"] = function()
  local pattern = (recurring_dir .. "/*.json")
  local files = vim.fn.glob(pattern, true, true)
  local meetings = {}
  for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    table.insert(meetings, name)
  end
  return meetings
end
M["find-previous"] = function(recurring_name)
  local pattern = (meetings_dir .. "/*/*/????-??-??_????_" .. recurring_name .. ".md")
  local files = vim.fn.glob(pattern, true, true)
  if (#files > 0) then
    return files[#files]
  else
    return nil
  end
end
M["copy-actions"] = function(from_file)
  if (from_file and (vim.fn.filereadable(from_file) == 1)) then
    local lines = vim.fn.readfile(from_file)
    local actions = {}
    local in_actions = false
    for _, line in ipairs(lines) do
      if line:match("^## Action Items") then
        in_actions = true
      else
      end
      if (in_actions and line:match("^## ")) then
        if not line:match("^## Action Items") then
          in_actions = false
        else
        end
      else
      end
      if (in_actions and line:match("^%s*%- %[ %]")) then
        table.insert(actions, line)
      else
      end
    end
    return actions
  else
    return {}
  end
end
M["create-recurring"] = function(name)
  local config = M["load-recurring-config"](name)
  if config then
    local title = config.title
    local template = (config.template or "standard")
    local prev_file = M["find-previous"](name)
    local prev_actions = M["copy-actions"](prev_file)
    local paths = M["get-date-paths"]()
    local filename = (paths.date .. "_" .. paths.time .. "_" .. name .. ".md")
    local filepath = (paths["month-dir"] .. "/" .. filename)
    M["ensure-dir"](paths["month-dir"])
    vim.cmd(("edit " .. filepath))
    local template_content = M["load-template"](template)
    local content = M["process-template"](template_content)
    local lines = vim.split(content, "\n")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    if (#prev_actions > 0) then
      local current_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local action_idx = nil
      for i, line in ipairs(current_lines) do
        if line:match("^## Action Items") then
          action_idx = i
        else
        end
      end
      if action_idx then
        local before = vim.list_slice(current_lines, 1, (action_idx + 1))
        local after = vim.list_slice(current_lines, (action_idx + 2))
        local new_lines = vim.list_extend(vim.list_extend(before, vim.list_extend({"", "### Carried over from last meeting"}, prev_actions)), vim.list_extend({""}, after))
        vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
      else
      end
    else
    end
    if prev_file then
      local prev_name = vim.fn.fnamemodify(prev_file, ":t")
      local link = ("**Previous:** [[" .. prev_name .. "]]")
      vim.api.nvim_buf_set_lines(0, 1, 1, false, {link, ""})
    else
    end
    vim.cmd("normal! gg")
    vim.cmd("nohlsearch")
    return vim.cmd("normal! }}")
  else
    return print(("Recurring meeting '" .. name .. "' not found. Create it with :MeetingRecurringSetup"))
  end
end
M["setup-recurring"] = function(name, template)
  local safe_name = string.gsub(string.gsub(string.lower(name), "%s+", "-"), "[^%w%-]", "")
  local config = {title = name, template = (template or "standard"), frequency = "weekly"}
  M["save-recurring-config"](safe_name, config)
  return print(("Created recurring meeting: " .. name .. " (" .. safe_name .. ")"))
end
M.recurring = function()
  local meetings = M["list-recurring"]()
  if (#meetings > 0) then
    local function _18_(choice)
      if choice then
        return M["create-recurring"](choice)
      else
        return nil
      end
    end
    return vim.ui.select(meetings, {prompt = "Select recurring meeting:"}, _18_)
  else
    return print("No recurring meetings configured. Use :MeetingRecurringSetup")
  end
end
local function _21_(opts)
  local title
  if (#opts.args > 0) then
    title = opts.args
  else
    title = "Meeting"
  end
  return M.create("standard", title)
end
vim.api.nvim_create_user_command("MeetingNew", _21_, {nargs = "?"})
vim.api.nvim_create_user_command("MeetingSearch", M.search, {})
vim.api.nvim_create_user_command("MeetingFind", M.find, {})
vim.api.nvim_create_user_command("MeetingToday", M.today, {})
vim.api.nvim_create_user_command("MeetingExtractActions", M["extract-actions"], {})
local function _23_(opts)
  if (#opts.args > 0) then
    return M["create-recurring"](opts.args)
  else
    return M.recurring()
  end
end
vim.api.nvim_create_user_command("MeetingRecurring", _23_, {nargs = "?"})
local function _25_(opts)
  if (#opts.args > 0) then
    return M["setup-recurring"](opts.args)
  else
    return print("Usage: :MeetingRecurringSetup <name> [template]")
  end
end
vim.api.nvim_create_user_command("MeetingRecurringSetup", _25_, {nargs = "?"})
vim.keymap.set("n", "<leader>mn", ":MeetingNew ", {desc = "Meeting: New"})
vim.keymap.set("n", "<leader>mf", ":MeetingFind<CR>", {desc = "Meeting: Find"})
vim.keymap.set("n", "<leader>ms", ":MeetingSearch<CR>", {desc = "Meeting: Search"})
vim.keymap.set("n", "<leader>mt", ":MeetingToday<CR>", {desc = "Meeting: Today's meetings"})
vim.keymap.set("n", "<leader>ma", ":MeetingExtractActions<CR>", {desc = "Meeting: Extract actions"})
vim.keymap.set("n", "<leader>mR", ":MeetingRecurring<CR>", {desc = "Meeting: Start recurring"})
return vim.keymap.set("n", "<leader>mS", ":MeetingRecurringSetup ", {desc = "Meeting: Setup recurring"})
