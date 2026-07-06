local M = {}

M.config = {
  notes_dir = vim.fn.expand("~/notes"),
  include_done = false,
}

local date_patterns = {
  "%d%d%d%d%-%d%d%-%d%d", -- 2026-07-06
}

local function has_date(line)
  for _, pat in ipairs(date_patterns) do
    local date = line:match(pat)
    if date then return date end
  end
end

local function is_task_or_list_item(line)
  return line:match("^%s*[-*+]%s+") ~= nil
end

local function is_done(line)
  return line:match("^%s*[-*+]%s+%[x%]") or line:match("^%s*[-*+]%s+%[X%]")
end

local function scan_file(path, items)
  local file = io.open(path, "r")
  if not file then return end

  local lnum = 0
  for line in file:lines() do
    lnum = lnum + 1

    local date = has_date(line)
    if date and is_task_or_list_item(line) then
      if M.config.include_done or not is_done(line) then
        table.insert(items, {
          filename = path,
          lnum = lnum,
          col = 1,
          text = "[" .. date .. "] " .. line:gsub("^%s*", ""),
          date = date,
        })
      end
    end
  end

  file:close()
end

function M.collect()
  local items = {}
  local notes_dir = vim.fn.expand(M.config.notes_dir)

  local files = vim.fs.find(function(name, path)
    return name:match("%.md$")
  end, {
    path = notes_dir,
    type = "file",
    limit = math.huge,
  })

  for _, path in ipairs(files) do
    scan_file(path, items)
  end

  table.sort(items, function(a, b)
    return a.date < b.date
  end)

  return items
end

function M.open_quickfix()
  local items = M.collect()

  vim.fn.setqflist({}, " ", {
    title = "Markdown Agenda",
    items = items,
  })

  vim.cmd("copen")
end

function M.today()
  local today = os.date("%Y-%m-%d")
  local items = vim.tbl_filter(function(item)
    return item.date <= today
  end, M.collect())

  vim.fn.setqflist({}, " ", {
    title = "Markdown Agenda: Today",
    items = items,
  })

  vim.cmd("copen")
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  vim.api.nvim_create_user_command("MarkdownAgenda", function()
    M.open_quickfix()
  end, {})

  vim.api.nvim_create_user_command("MarkdownAgendaToday", function()
    M.today()
  end, {})
end

return M
