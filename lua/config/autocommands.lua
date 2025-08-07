-- [nfnl] fnl/config/autocommands.fnl
local function _1_()
  return vim.diagnostic.open_float()
end
vim.api.nvim_create_autocmd({"CursorHold"}, {callback = _1_, pattern = "*"})
local function _2_()
  return vim.lsp.buf.format()
end
vim.api.nvim_create_autocmd({"BufWritePre"}, {callback = _2_})
vim.api.nvim_create_autocmd("QuickFixCmdPost", {command = vim.cmd("cwindow"), nested = true, pattern = {"[^l]*"}})
local function _3_()
  vim.opt.bufhidden = "delete"
  return nil
end
vim.api.nvim_create_autocmd("Filetype", {callback = _3_, pattern = {"gitcommit", "gitrebase", "gitconfig"}})
local function _4_()
  vim.wo.number = false
  vim.wo.relativenumber = false
  return nil
end
vim.api.nvim_create_autocmd("TermOpen", {callback = _4_, pattern = {"*"}})
local function _5_()
  local output = vim.fn.system(("fennel -c " .. vim.fn.expand("%") .. " > " .. vim.fn.expand("%:r") .. ".lua"))
  if (vim.v.shell_error ~= 0) then
    return vim.notify(("Error compiling wezterm.fnl:\n" .. output), vim.log.levels.ERROR)
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("BufWritePost", {pattern = "wezterm.fnl", callback = _5_})
local function insert_neorg_link()
  local link = vim.fn.input("Link: ")
  local text = vim.fn.input("Text: ")
  return vim.api.nvim_set_current_line(("{" .. link .. "}[" .. text .. "]"))
end
local function insert_markdown_link()
  local link = vim.fn.input("Link: ")
  local text = vim.fn.input("Text: ")
  return vim.api.nvim_set_current_line(("[" .. text .. "](" .. link .. ")"))
end
local function _7_()
  vim.opt_local.conceallevel = 2
  vim.opt_local.wrap = false
  vim.keymap.set("n", "<leader>t", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", {buffer = true})
  vim.keymap.set("i", "<C-l>", insert_neorg_link, {buffer = true})
  return vim.keymap.set("i", "<C-d>", "<Plug>(neorg.tempus.insert-date.insert-mode)", {buffer = true})
end
vim.api.nvim_create_autocmd("Filetype", {callback = _7_, pattern = "norg"})
local function _8_()
  return vim.keymap.set("i", "<C-l>", insert_markdown_link, {buffer = true})
end
vim.api.nvim_create_autocmd("Filetype", {callback = _8_, pattern = "markdown"})
local function _9_(event)
  local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
  if ((client ~= nil) and (client.name == "Firenvim")) then
    vim.o.laststatus = 0
    return nil
  else
    return nil
  end
end
return vim.api.nvim_create_autocmd({"UIEnter"}, {callback = _9_})
