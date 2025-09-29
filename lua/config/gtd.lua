-- [nfnl] fnl/config/gtd.fnl
local M = {}
local gtd_dir = vim.fn.expand("~/gtd")
M.capture = function()
  vim.cmd(("edit " .. gtd_dir .. "/inbox.md"))
  vim.cmd("normal! Go")
  vim.cmd(("normal! o## " .. os.date("%Y-%m-%d %H:%M")))
  vim.cmd("normal! o")
  return vim.cmd("startinsert")
end
M["open-file"] = function(filename)
  return vim.cmd(("edit " .. gtd_dir .. "/" .. filename))
end
M.inbox = function()
  return M["open-file"]("inbox.md")
end
M.next = function()
  return M["open-file"]("next.md")
end
M.projects = function()
  return M["open-file"]("projects.md")
end
M.waiting = function()
  return M["open-file"]("waiting.md")
end
M.someday = function()
  return M["open-file"]("someday.md")
end
M.review = function()
  local files = {"inbox.md", "next.md", "projects.md", "waiting.md"}
  for _, file in ipairs(files) do
    vim.cmd(("tabnew " .. gtd_dir .. "/" .. file))
  end
  return nil
end
M["find-files"] = function()
  local snacks = require("snacks")
  return snacks.picker.files({cwd = gtd_dir})
end
M.grep = function()
  local snacks = require("snacks")
  return snacks.picker.grep({cwd = gtd_dir})
end
vim.api.nvim_create_user_command("GTDCapture", M.capture, {})
vim.api.nvim_create_user_command("GTDInbox", M.inbox, {})
vim.api.nvim_create_user_command("GTDNext", M.next, {})
vim.api.nvim_create_user_command("GTDProjects", M.projects, {})
vim.api.nvim_create_user_command("GTDWaiting", M.waiting, {})
vim.api.nvim_create_user_command("GTDSomeday", M.someday, {})
vim.api.nvim_create_user_command("GTDReview", M.review, {})
vim.keymap.set("n", "<leader>nc", M.capture, {desc = "GTD: Quick Capture"})
vim.keymap.set("n", "<leader>ni", M.inbox, {desc = "GTD: Open Inbox"})
vim.keymap.set("n", "<leader>nn", M.next, {desc = "GTD: Next Actions"})
vim.keymap.set("n", "<leader>np", M.projects, {desc = "GTD: Projects"})
vim.keymap.set("n", "<leader>nw", M.waiting, {desc = "GTD: Waiting For"})
vim.keymap.set("n", "<leader>ns", M.someday, {desc = "GTD: Someday/Maybe"})
vim.keymap.set("n", "<leader>nr", M.review, {desc = "GTD: Weekly Review"})
vim.keymap.set("n", "<leader>nf", M["find-files"], {desc = "GTD: Find Files"})
vim.keymap.set("n", "<leader>ng", M.grep, {desc = "GTD: Search Content"})
M["capture-from-meeting"] = function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local actions = {}
  local meeting_file = vim.fn.expand("%:t:r")
  for _, line in ipairs(lines) do
    if line:match("^%s*%- %[ %]") then
      local action = (line .. " [from: " .. meeting_file .. "]")
      table.insert(actions, action)
    else
    end
  end
  if (#actions > 0) then
    local inbox_path = (gtd_dir .. "/inbox.md")
    local existing = vim.fn.readfile(inbox_path)
    local new_content = vim.list_extend(existing, vim.list_extend({"", ("## " .. os.date("%Y-%m-%d %H:%M") .. " - Meeting Actions")}, actions))
    vim.fn.writefile(new_content, inbox_path)
    return print(("Captured " .. #actions .. " actions to GTD inbox"))
  else
    return nil
  end
end
vim.api.nvim_create_user_command("GTDCaptureFromMeeting", M["capture-from-meeting"], {})
return vim.keymap.set("n", "<leader>nm", ":GTDCaptureFromMeeting<CR>", {desc = "GTD: Capture from meeting"})
