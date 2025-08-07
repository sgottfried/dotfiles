-- [nfnl] fnl/config/keybindings.fnl
local default_opts = {remap = false}
local wk = require("which-key")
local function _1_()
  return require("dap").toggle_breakpoint()
end
local function _2_()
  return require("telescope").extensions.projects.projects({})
end
local function _3_()
  local term_buf = vim.fn.bufnr("term://*")
  if (term_buf == ( - 1)) then
    return vim.cmd("botright split | resize 20 | terminal")
  else
    return vim.cmd(("botright split | resize 20 | buffer " .. term_buf))
  end
end
local function _5_()
  return require("neotest").run.run({strategy = "dap"})
end
local function _6_()
  return require("neotest").run.run({jestCommand = "npx jest --coverage"})
end
local function _7_()
  return require("neotest").run.run(vim.fn.expand("%"))
end
local function _8_()
  return require("neotest").run.run()
end
wk.add({{"gb", _1_, desc = "toggle breakpoint"}, {"<leader>;", ":", desc = "Run Command"}, {"<leader><leader>", ":Telescope find_files<CR>", desc = "Telescope find files"}, {"<leader>b", group = "buffer"}, {"<leader>bS", ":noa w<CR>", desc = "Save (without formatting)"}, {"<leader>bi", ":Telescope buffers<CR>", desc = "List buffers"}, {"<leader>bs", ":w<CR>", desc = "Save"}, {"<leader>c", ":copen<CR>", desc = "Open Quickfix"}, {"<leader>d", group = "debugger"}, {"<leader>dd", ":DapContinue<CR>", desc = "Continue Debugging"}, {"<leader>di", ":DapStepInto<CR>", desc = "Step Into"}, {"<leader>do", ":DapStepOver<CR>", desc = "Step Over"}, {"<leader>g", group = "Git"}, {"<leader>gd", ":Gvdiffsplit<CR>", desc = "Fugitive Diff"}, {"<leader>gD", ":Gvdiffsplit!<CR>", desc = "Fugitive Merge"}, {"<leader>gg", ":G<CR>", desc = "Open Fugitive"}, {"<leader>hh", ":Telescope help_tags<CR>", desc = "Search Helptags"}, {"<leader>p", _2_, desc = "Switch Project"}, {"<leader>nj", ":Neorg journal today<CR>", desc = "Neorg journal for today"}, {"<leader>nm", ":MigrateYesterdayTasks<CR>", desc = "Neorg journal migrate tasks"}, {"<leader>ot", _3_, desc = "Open Terminal"}, {"<leader>s", ":Telescope live_grep<CR>", desc = "Search project"}, {"<leader>t", group = "Neotest"}, {"<leader>td", _5_, desc = "debug test"}, {"<leader>tt", _6_, desc = "run test under cursor"}, {"<leader>tf", _7_, desc = "test file"}, {"<leader>tt", _8_, desc = "run test under cursor"}, {"<leader>tw", "<cmd>lua require('neotest').run.run({ jestCommand = 'npx jest --watch ' })<cr>", desc = "run test watch"}, {"<leader>w", group = "windows", proxy = "<c-w>"}, {"<leader>x", ":.lua<CR>", desc = "Execute Lua line"}})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "Y", "\"+y", default_opts)
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", default_opts)
vim.keymap.set("t", "jk", "<C-\\><C-n>", default_opts)
vim.keymap.set("v", "Y", "\"+y", default_opts)
return vim.keymap.set("v", "<leader>x", ":lua<CR>", default_opts)
