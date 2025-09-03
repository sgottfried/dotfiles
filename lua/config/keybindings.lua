-- [nfnl] fnl/config/keybindings.fnl
local default_opts = {remap = false}
local wk = require("which-key")
local function _1_(...)
  local tbl_21_ = {}
  local i_22_ = 0
  for __2_auto, _2_ in ipairs({{"S", ":noa w<CR>", "Save (without formatting)"}, {"i", ":Telescope buffers<CR>", "List buffers"}, {"s", ":w<CR>", "Save"}}) do
    local keybinding_3_auto = _2_[1]
    local command_4_auto = _2_[2]
    local desc_5_auto = _2_[3]
    local val_23_ = {("<leader>b" .. keybinding_3_auto), command_4_auto, desc = desc_5_auto}
    if (nil ~= val_23_) then
      i_22_ = (i_22_ + 1)
      tbl_21_[i_22_] = val_23_
    else
    end
  end
  return tbl_21_
end
wk.add(_1_(...))
local function _4_(...)
  local tbl_21_ = {}
  local i_22_ = 0
  for __2_auto, _5_ in ipairs({{"d", ":DapContinue<CR>", "Continue Debugging"}, {"i", ":DapStepInto<CR>", "Step Into"}, {"o", ":DapStepOver<CR>", "Step Over"}}) do
    local keybinding_3_auto = _5_[1]
    local command_4_auto = _5_[2]
    local desc_5_auto = _5_[3]
    local val_23_ = {("<leader>d" .. keybinding_3_auto), command_4_auto, desc = desc_5_auto}
    if (nil ~= val_23_) then
      i_22_ = (i_22_ + 1)
      tbl_21_[i_22_] = val_23_
    else
    end
  end
  return tbl_21_
end
wk.add(_4_(...))
local function _7_(...)
  local tbl_21_ = {}
  local i_22_ = 0
  for __2_auto, _8_ in ipairs({{"D", ":Gvdiffsplit!<CR>", "Git Merge"}, {"d", ":Gvdiffsplit<CR>", "Git Diff"}, {"g", ":G<CR>", "Open Fugitive"}}) do
    local keybinding_3_auto = _8_[1]
    local command_4_auto = _8_[2]
    local desc_5_auto = _8_[3]
    local val_23_ = {("<leader>g" .. keybinding_3_auto), command_4_auto, desc = desc_5_auto}
    if (nil ~= val_23_) then
      i_22_ = (i_22_ + 1)
      tbl_21_[i_22_] = val_23_
    else
    end
  end
  return tbl_21_
end
wk.add(_7_(...))
local function _10_(...)
  local tbl_21_ = {}
  local i_22_ = 0
  for __2_auto, _11_ in ipairs({{"m", ":MigrateYesterdayTasks<CR>", "Neorg journal migrate tasks"}, {"j", ":Neorg journal today<CR>", "Neorg journal for today"}}) do
    local keybinding_3_auto = _11_[1]
    local command_4_auto = _11_[2]
    local desc_5_auto = _11_[3]
    local val_23_ = {("<leader>n" .. keybinding_3_auto), command_4_auto, desc = desc_5_auto}
    if (nil ~= val_23_) then
      i_22_ = (i_22_ + 1)
      tbl_21_[i_22_] = val_23_
    else
    end
  end
  return tbl_21_
end
wk.add(_10_(...))
local function _13_(...)
  local tbl_21_ = {}
  local i_22_ = 0
  local function _15_()
    return require("neotest").run.run({strategy = "dap"})
  end
  local function _16_()
    return require("neotest").run.run(vim.fn.expand("%"))
  end
  local function _17_()
    return require("neotest").run.run({jestCommand = "npx jest --coverage"})
  end
  for __2_auto, _14_ in ipairs({{"d", _15_, "Debug Test"}, {"f", _16_, "Test File"}, {"t", _17_, "Run Test Under Cursor"}, {"w", "<cmd>lua require('neotest').run.run({ jestCommand = 'npx jest --watch ' })<cr>", "Run Test in Watch Mode"}}) do
    local keybinding_3_auto = _14_[1]
    local command_4_auto = _14_[2]
    local desc_5_auto = _14_[3]
    local val_23_ = {("<leader>t" .. keybinding_3_auto), command_4_auto, desc = desc_5_auto}
    if (nil ~= val_23_) then
      i_22_ = (i_22_ + 1)
      tbl_21_[i_22_] = val_23_
    else
    end
  end
  return tbl_21_
end
wk.add(_13_(...))
vim.keymap.set("i", "jk", "<Esc>")
wk.add({{"-", ":Oil<CR>", desc = "Open parent directory"}})
wk.add({{"<leader>;", ":", desc = "desc"}})
wk.add({{"<leader><leader>", ":Telescope find_files<CR>", desc = "Telescope find files"}})
wk.add({{"<leader>c", ":copen<CR>", desc = "Open Quickfix"}})
wk.add({{"<leader>hh", ":Telescope help_tags<CR>", desc = "Search Helptags"}})
local function _19_()
  local term_buf = vim.fn.bufnr("term://*")
  if (term_buf == ( - 1)) then
    return vim.cmd("botright split | resize 20 | terminal")
  else
    return vim.cmd(("botright split | resize 20 | buffer " .. term_buf))
  end
end
wk.add({{"<leader>ot", _19_, desc = "Open Terminal"}})
wk.add({{"<leader>s", ":Telescope live_grep<CR>", desc = "Search project"}})
wk.add({{"<leader>x", ":.lua<CR>", desc = "Execute Lua line"}})
wk.add({{"gb", ":DapToggleBreakpoint<CR>", desc = "toggle breakpoint"}})
wk.add({{"Y", "\"+y", desc = "Yank to system clipboard"}})
wk.add({{"<leader>w", group = "windows", proxy = "<c-w>"}})
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", default_opts)
vim.keymap.set("t", "jk", "<C-\\><C-n>", default_opts)
vim.keymap.set("v", "<leader>x", ":lua<CR>", default_opts)
return vim.keymap.set("v", "Y", "\"+y", default_opts)
