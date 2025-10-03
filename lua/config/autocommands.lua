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
  vim.bo.number = false
  vim.bo.relativenumber = false
  return nil
end
vim.api.nvim_create_autocmd("TermOpen", {callback = _4_, pattern = {"*"}})
do
  local _5_, _6_ = pcall(require, "nfnl.api.compile-file")
  if ((_5_ == true) and (nil ~= _6_)) then
    local nfnl_compile = _6_
    print("NFNL compile module loaded successfully!")
    local nfnl_group = vim.api.nvim_create_augroup("nfnl-compile", {clear = true})
    local function _7_()
      local file = vim.fn.expand("%:p")
      print(("Compiling " .. file))
      return nfnl_compile(file)
    end
    vim.api.nvim_create_autocmd("BufWritePost", {group = nfnl_group, pattern = "*.fnl", callback = _7_})
  else
  end
end
local function vim_feedkeys(keys)
  return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "m", false)
end
local function _9_()
  return vim_feedkeys("<leader>otA")
end
vim.api.nvim_create_autocmd("BufWinLeave", {pattern = {"COMMIT_EDITMSG", "MERGE_MSG", "REBASE_EDITMSG"}, callback = _9_, desc = "Run <leader>ot when closing git commit/rebase/merge buffers"})
local function _10_()
  local output = vim.fn.system(("fennel -c " .. vim.fn.expand("%") .. " > " .. vim.fn.expand("%:r") .. ".lua"))
  if (vim.v.shell_error ~= 0) then
    return vim.notify(("Error compiling wezterm.fnl:\n" .. output), vim.log.levels.ERROR)
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("BufWritePost", {pattern = "wezterm.fnl", callback = _10_})
local function insert_markdown_link()
  local link = vim.fn.input("Link: ")
  local text = vim.fn.input("Text: ")
  return vim.api.nvim_set_current_line(("[" .. text .. "](" .. link .. ")"))
end
local function _12_()
  return vim.keymap.set("i", "<C-l>", insert_markdown_link, {buffer = true})
end
vim.api.nvim_create_autocmd("Filetype", {callback = _12_, pattern = "markdown"})
local function _13_(event)
  local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
  if ((client ~= nil) and (client.name == "Firenvim")) then
    vim.o.laststatus = 0
    return nil
  else
    return nil
  end
end
return vim.api.nvim_create_autocmd({"UIEnter"}, {callback = _13_})
