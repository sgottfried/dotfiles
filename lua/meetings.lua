local M = {}

local meetings_dir = vim.fn.expand("~/meetings")

function M.get_date_paths()
  local year = os.date("%Y")
  local month = os.date("%m-%B")
  local date = os.date("%Y-%m-%d")
  local time = os.date("%H%M")
  return {
    year = year,
    month = month,
    date = date,
    time = time,
    month_dir = meetings_dir .. "/" .. year .. "/" .. month
  }
end

function M.ensure_dir(path)
  vim.fn.mkdir(path, "p")
end

function M.load_template(template_name)
  local template_path = meetings_dir .. "/templates/" .. template_name .. ".md"
  local file = io.open(template_path, "r")
  if file then
    local content = file:read("*a")
    file:close()
    return content
  end
  return ""
end

function M.process_template(content)
  content = content:gsub("{{date}}", os.date("%Y-%m-%d"))
  content = content:gsub("{{time}}", os.date("%H:%M"))
  content = content:gsub("{{datetime}}", os.date("%Y-%m-%d %H:%M"))
  content = content:gsub("{{day}}", os.date("%A"))
  return content:gsub("{{week}}", os.date("%W"))
end

function M.create(template_name, title)
  local paths = M.get_date_paths()
  local safe_title = title:lower():gsub("%s+", "-"):gsub("[^%w%-]", "")
  local filename = paths.date .. "_" .. paths.time .. "_" .. safe_title .. ".md"
  local filepath = paths.month_dir .. "/" .. filename

  M.ensure_dir(paths.month_dir)
  vim.cmd("edit " .. filepath)

  local template = M.load_template(template_name)
  local content = M.process_template(template)
  if content ~= "" then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n"))
  end

  vim.cmd("normal! gg")
  vim.cmd("normal! /" .. (title or "# "))
  vim.cmd("nohlsearch")
  vim.cmd("normal! $")
  vim.cmd("startinsert")
end

function M.search()
  local snacks = require("snacks")
  snacks.picker.grep({ cwd = meetings_dir })
end

function M.find()
  local snacks = require("snacks")
  snacks.picker.files({ cwd = meetings_dir })
end

function M.today()
  local paths = M.get_date_paths()
  local today_pattern = paths.month_dir .. "/" .. paths.date .. "_*.md"
  local files = vim.fn.glob(today_pattern, true, true)
  if #files > 0 then
    for _, file in ipairs(files) do
      vim.cmd("edit " .. file)
    end
  else
    print("No meetings today")
  end
end

function M.extract_actions()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local actions = {}
  for _, line in ipairs(lines) do
    if line:match("^%s*%- %[ %]") then
      table.insert(actions, line)
    end
  end
  if #actions > 0 then
    vim.cmd("new")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.list_extend({"# Action Items", ""}, actions))
    vim.bo.buftype = "nofile"
  else
    print("No action items found")
  end
end

-- Recurring meetings
local recurring_dir = meetings_dir .. "/recurring"

function M.load_recurring_config(name)
  local config_path = recurring_dir .. "/" .. name .. ".json"
  local file = io.open(config_path, "r")
  if file then
    local content = file:read("*a")
    file:close()
    return vim.json.decode(content)
  end
  return nil
end

function M.save_recurring_config(name, config)
  M.ensure_dir(recurring_dir)
  local config_path = recurring_dir .. "/" .. name .. ".json"
  local file = io.open(config_path, "w")
  local json = vim.json.encode(config)
  file:write(json)
  file:close()
end

function M.list_recurring()
  local pattern = recurring_dir .. "/*.json"
  local files = vim.fn.glob(pattern, true, true)
  local meetings = {}
  for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    table.insert(meetings, name)
  end
  return meetings
end

function M.find_previous(recurring_name)
  local pattern = meetings_dir .. "/*/*/????-??-??_????_" .. recurring_name .. ".md"
  local files = vim.fn.glob(pattern, true, true)
  if #files > 0 then
    return files[#files]
  end
  return nil
end

function M.copy_actions(from_file)
  if from_file and vim.fn.filereadable(from_file) == 1 then
    local lines = vim.fn.readfile(from_file)
    local actions = {}
    local in_actions = false
    for _, line in ipairs(lines) do
      if line:match("^## Action Items") then
        in_actions = true
      end
      if in_actions and line:match("^## ") then
        if not line:match("^## Action Items") then
          in_actions = false
        end
      end
      if in_actions and line:match("^%s*%- %[ %]") then
        table.insert(actions, line)
      end
    end
    return actions
  end
  return {}
end

function M.create_recurring(name)
  local config = M.load_recurring_config(name)
  if config then
    local title = config.title
    local template = config.template or "standard"
    local prev_file = M.find_previous(name)
    local prev_actions = M.copy_actions(prev_file)
    local paths = M.get_date_paths()
    local filename = paths.date .. "_" .. paths.time .. "_" .. name .. ".md"
    local filepath = paths.month_dir .. "/" .. filename

    M.ensure_dir(paths.month_dir)
    vim.cmd("edit " .. filepath)

    local template_content = M.load_template(template)
    local content = M.process_template(template_content)
    local lines = vim.split(content, "\n")

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    -- Add previous action items
    if #prev_actions > 0 then
      local current_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local action_idx = nil
      for i, line in ipairs(current_lines) do
        if line:match("^## Action Items") then
          action_idx = i
        end
      end

      if action_idx then
        local before = vim.list_slice(current_lines, 1, action_idx + 1)
        local after = vim.list_slice(current_lines, action_idx + 2)
        local new_lines = vim.list_extend(
          vim.list_extend(before, vim.list_extend({"", "### Carried over from last meeting"}, prev_actions)),
          vim.list_extend({""}, after)
        )
        vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
      end
    end

    -- Add link to previous meeting
    if prev_file then
      local prev_name = vim.fn.fnamemodify(prev_file, ":t")
      local link = "**Previous:** [[" .. prev_name .. "]]"
      vim.api.nvim_buf_set_lines(0, 1, 1, false, {link, ""})
    end

    vim.cmd("normal! gg")
    vim.cmd("nohlsearch")
    vim.cmd("normal! }}")
  else
    print("Recurring meeting '" .. name .. "' not found. Create it with :MeetingRecurringSetup")
  end
end

function M.setup_recurring(name, template)
  local safe_name = name:lower():gsub("%s+", "-"):gsub("[^%w%-]", "")
  local config = {
    title = name,
    template = template or "standard",
    frequency = "weekly"
  }
  M.save_recurring_config(safe_name, config)
  print("Created recurring meeting: " .. name .. " (" .. safe_name .. ")")
end

function M.recurring()
  local meetings = M.list_recurring()
  if #meetings > 0 then
    vim.ui.select(meetings, {
      prompt = "Select recurring meeting:"
    }, function(choice)
      if choice then
        M.create_recurring(choice)
      end
    end)
  else
    print("No recurring meetings configured. Use :MeetingRecurringSetup")
  end
end

-- Commands
vim.api.nvim_create_user_command("MeetingNew", function(opts)
  local title = #opts.args > 0 and opts.args or "Meeting"
  M.create("standard", title)
end, {nargs = "?"})

vim.api.nvim_create_user_command("MeetingSearch", M.search, {})
vim.api.nvim_create_user_command("MeetingFind", M.find, {})
vim.api.nvim_create_user_command("MeetingToday", M.today, {})
vim.api.nvim_create_user_command("MeetingExtractActions", M.extract_actions, {})

vim.api.nvim_create_user_command("MeetingRecurring", function(opts)
  if #opts.args > 0 then
    M.create_recurring(opts.args)
  else
    M.recurring()
  end
end, {nargs = "?"})

vim.api.nvim_create_user_command("MeetingRecurringSetup", function(opts)
  if #opts.args > 0 then
    M.setup_recurring(opts.args)
  else
    print("Usage: :MeetingRecurringSetup <name> [template]")
  end
end, {nargs = "?"})

-- Keymaps
vim.keymap.set("n", "<leader>mn", ":MeetingNew ", {desc = "Meeting: New"})
vim.keymap.set("n", "<leader>mf", ":MeetingFind<CR>", {desc = "Meeting: Find"})
vim.keymap.set("n", "<leader>ms", ":MeetingSearch<CR>", {desc = "Meeting: Search"})
vim.keymap.set("n", "<leader>mt", ":MeetingToday<CR>", {desc = "Meeting: Today's meetings"})
vim.keymap.set("n", "<leader>ma", ":MeetingExtractActions<CR>", {desc = "Meeting: Extract actions"})
vim.keymap.set("n", "<leader>mR", ":MeetingRecurring<CR>", {desc = "Meeting: Start recurring"})
vim.keymap.set("n", "<leader>mS", ":MeetingRecurringSetup ", {desc = "Meeting: Setup recurring"})

return M
