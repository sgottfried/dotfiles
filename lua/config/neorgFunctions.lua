-- [nfnl] fnl/config/neorgFunctions.fnl
local function migrate_yesterday_tasks()
  local yesterday = os.date("%Y/%m/%d", (os.time() - 86400))
  local yesterday_file = vim.fn.expand(("~/notes/journal/" .. yesterday .. ".norg"))
  local today = os.date("%Y/%m/%d")
  local today_file = vim.fn.expand(("~/notes/journal/" .. today .. ".norg"))
  local file = io.open(yesterday_file, "r")
  if not file then
    return 
  else
  end
  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end
  file:close()
  local new_lines = {}
  local tasks_by_heading = {}
  local current_heading = nil
  for _, line in ipairs(lines) do
    if ((line:match("^%*+ ") and not line:match("%( %)")) and not line:match("%(x%)")) then
      current_heading = line
      tasks_by_heading[current_heading] = (tasks_by_heading[current_heading] or {})
      table.insert(new_lines, line)
    elseif ((line:match("%(%s*%)") or line:match("%(-%)")) or line:match("%(=%)")) then
      local started_date = line:match("@started%((%d%d%d%d%-%d%d%-%d%d)%)")
      if not started_date then
        started_date = yesterday
        line = (line .. " @started(" .. started_date .. ")")
      else
      end
      if current_heading then
        table.insert(tasks_by_heading[current_heading], line)
      else
        table.insert(tasks_by_heading, line)
      end
    else
      table.insert(new_lines, line)
    end
  end
  local file0 = io.open(yesterday_file, "w")
  if file0 then
    for _, line in ipairs(new_lines) do
      file0:write((line .. "\n"))
    end
    file0:close()
  else
  end
  local today_lines = {}
  local existing_tasks = {}
  local file1 = io.open(today_file, "r")
  if file1 then
    for line in file1:lines() do
      table.insert(today_lines, line)
      existing_tasks[line] = true
    end
    file1:close()
  else
  end
  local output_lines = {}
  current_heading = nil
  for _, line in ipairs(today_lines) do
    table.insert(output_lines, line)
    if tasks_by_heading[line] then
      for _0, task in ipairs(tasks_by_heading[line]) do
        if not existing_tasks[task] then
          table.insert(output_lines, task)
        else
        end
      end
      tasks_by_heading[line] = nil
    else
    end
  end
  for heading, tasks in pairs(tasks_by_heading) do
    table.insert(output_lines, heading)
    for _, task in ipairs(tasks) do
      if not existing_tasks[task] then
        table.insert(output_lines, task)
      else
      end
    end
  end
  local file2 = io.open(today_file, "w")
  if file2 then
    for _, line in ipairs(output_lines) do
      file2:write((line .. "\n"))
    end
    file2:close()
  else
  end
  return vim.notify("Migrated tasks to today's journal!", vim.log.levels.INFO)
end
local function _11_()
  return migrate_yesterday_tasks()
end
return vim.api.nvim_create_user_command("MigrateYesterdayTasks", _11_, {})
