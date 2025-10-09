-- [nfnl] fnl/config/keybindings.fnl
local default_opts = {remap = false}
local wk = require("which-key")
local function _1_(...)
  local tbl_21_ = {}
  local i_22_ = 0
  for __2_auto, _2_ in ipairs({{"S", ":noa w<CR>", "Save (without formatting)"}, {"i", ":lua Snacks.picker.buffers()<CR>", "List buffers"}, {"s", ":w<CR>", "Save"}}) do
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
  for __2_auto, _8_ in ipairs({{"D", ":Gvdiffsplit!<CR>", "Git Merge"}, {"b", ":Git blame<CR>", "Git Blame"}, {"d", ":Gvdiffsplit<CR>", "Git Diff"}, {"g", ":G<CR>", "Open Fugitive"}}) do
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
wk.add({{"<leader>n", group = "notes"}})
vim.keymap.set("i", "jk", "<Esc>")
wk.add({{"-", ":Oil<CR>", desc = "Open parent directory"}})
wk.add({{"<leader>;", ":", desc = "desc"}})
wk.add({{"<leader><leader>", ":lua Snacks.picker.smart()<CR>", desc = "Snacks find files"}})
wk.add({{"<leader>c", ":copen<CR>", desc = "Open Quickfix"}})
wk.add({{"<leader>hh", ":lua Snacks.picker.help()<CR>", desc = "Search Helptags"}})
local function _10_()
  local term_buf = vim.fn.bufnr("term://*")
  if (term_buf == ( - 1)) then
    return vim.cmd("botright split | resize 20 | terminal")
  else
    return vim.cmd(("botright split | resize 20 | buffer " .. term_buf))
  end
end
wk.add({{"<leader>ot", _10_, desc = "Open Terminal"}})
wk.add({{"<leader>s", ":lua Snacks.picker.grep()<CR>", desc = "Search project"}})
wk.add({{"<leader>x", ":.lua<CR>", desc = "Execute Lua line"}})
wk.add({{"gb", ":DapToggleBreakpoint<CR>", desc = "toggle breakpoint"}})
local function _12_()
  return vim.lsp.buf.definition()
end
wk.add({{"gd", _12_, desc = "LSP Go to definition"}})
local function _13_()
  return vim.lsp.buf.hover()
end
wk.add({{"gh", _13_, desc = "LSP Hover"}})
local function _14_()
  return vim.lsp.buf.references()
end
wk.add({{"gr", _14_, desc = "LSP references"}})
local function _15_()
  return vim.lsp.buf.rename()
end
wk.add({{"gR", _15_, desc = "LSP rename"}})
wk.add({{"Y", "\"+y", desc = "Yank to system clipboard"}})
wk.add({{"<leader>w", group = "windows", proxy = "<c-w>"}})
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", default_opts)
vim.keymap.set("t", "jk", "<C-\\><C-n>", default_opts)
vim.keymap.set("v", "<leader>x", ":lua<CR>", default_opts)
return vim.keymap.set("v", "Y", "\"+y", default_opts)
