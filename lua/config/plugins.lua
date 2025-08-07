-- [nfnl] fnl/config/plugins.fnl
local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
else
end
vim.opt.rtp:prepend(lazypath)
local function _2_()
end
local function _3_()
  return require("CopilotChat").setup()
end
local function _4_()
  vim.api.nvim_set_option_value("background", "dark", {})
  require("gruvbox").setup({contrast = "hard"})
  return vim.cmd("colorscheme gruvbox")
end
local function _5_()
  vim.api.nvim_set_option_value("background", "light", {})
  require("gruvbox").setup({contrast = "hard"})
  return vim.cmd("colorscheme gruvbox")
end
local function _6_()
  return require("which-key").show({global = false})
end
local function _7_()
  local function _8_(path)
    return vim.fn.getcwd()
  end
  return require("neotest").setup({adapters = {require("neotest-jest")({cwd = _8_, jestCommand = "npx jest"})}, icons = {failed = "\239\129\151", passed = "\239\129\152", running = "\239\132\140", unknown = "\239\129\153"}})
end
local function _9_()
  return require("coverage").setup({auto_reload = true})
end
local function _10_()
  require("mason-nvim-dap").setup({ensure_installed = {"js-debug-adapter"}})
  local dap = require("dap")
  dap.adapters["pwa-node"] = {executable = {args = {(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"), "9229"}, command = "node"}, host = "localhost", port = 9229, type = "server"}
  for _, language in ipairs({"javascript", "javascript.jsx", "typescript", "typescript.tsx"}) do
    dap.configurations[language] = {{console = "integratedTerminal", internalConsoleOptions = "neverOpen", name = "Debug Jest Tests", request = "launch", runtimeArgs = {"--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest", "--runInBand", "--no-cache"}, runtimeExecutable = "node", type = "pwa-node"}}
  end
  return require("dapui").setup()
end
local function _11_()
end
local function _12_()
  vim.g["conjure#debug"] = true
  return nil
end
local function _13_()
  require("telescope").setup({extensions = {["ui-select"] = {require("telescope.themes").get_dropdown({})}}})
  return require("telescope").load_extension("ui-select")
end
local function _14_()
  require("telescope").load_extension("projects")
  return require("project_nvim").setup({})
end
return require("lazy").setup({"APZelos/blamer.nvim", "HiPhish/rainbow-delimiters.nvim", "airblade/vim-gitgutter", "alnav3/sonarlint.nvim", "dhruvasagar/vim-table-mode", "github/copilot.vim", "hrsh7th/cmp-nvim-lsp", "hrsh7th/nvim-cmp", "ianks/vim-tsx", "leafgarland/typescript-vim", "mfussenegger/nvim-jdtls", "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim", "pangloss/vim-javascript", "tpope/vim-commentary", "tpope/vim-fugitive", "tpope/vim-projectionist", "tpope/vim-surround", "tpope/vim-unimpaired", "williamboman/mason.nvim", {"Olical/nfnl", ft = "fennel", config = _2_}, {"CopilotC-Nvim/CopilotChat.nvim", build = "make tiktoken", config = _3_, dependencies = {{"github/copilot.vim"}, {"nvim-lua/plenary.nvim", branch = "master"}}}, {"ellisonleao/gruvbox.nvim", config = true, priority = 1000}, {"f-person/auto-dark-mode.nvim", opts = {set_dark_mode = _4_, set_light_mode = _5_, update_interval = 1000}}, {"glacambre/firenvim", build = ":call firenvim#install(0)"}, {"folke/which-key.nvim", event = "VeryLazy", keys = {{"<leader>?", _6_, desc = "Buffer Local Keymaps (which-key)"}}}, {"nvim-neorg/neorg", dependencies = {{"nvim-lua/plenary.nvim"}, {"nvim-neorg/neorg-telescope"}}, opts = {load = {["core.concealer"] = {}, ["core.defaults"] = {}, ["core.dirman"] = {config = {default_workspace = "journal", workspaces = {journal = "~/notes"}}}, ["core.integrations.telescope"] = {config = {insert_file_link = {show_title_preview = true}}}, ["core.integrations.treesitter"] = {}, ["core.journal"] = {config = {workspace = "journal"}}, ["core.qol.todo_items"] = {}, ["core.ui"] = {}}}, version = "*", lazy = false}, {"nvim-neotest/neotest", config = _7_, dependencies = {"nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter", "nvim-neotest/neotest-jest"}, lazy = false}, {"andythigpen/nvim-coverage", config = _9_, version = "*"}, {"mfussenegger/nvim-dap", config = _10_, dependencies = {"rcarriga/nvim-dap-ui", "jay-babu/mason-nvim-dap.nvim"}}, {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}, {"vhyrro/luarocks.nvim", config = true, priority = 1000}, {"creativenull/efmls-configs-nvim", version = "v1.x.x"}, {"nvim-lualine/lualine.nvim", config = _11_, dependencies = {{"kyazdani42/nvim-web-devicons", opt = true}}}, {"stevearc/oil.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}}, {"Olical/conjure", ft = {"fennel"}, lazy = true, dependencies = {{"PaterJason/cmp-conjure"}}, init = _12_}, {"nvim-telescope/telescope.nvim", config = _13_, dependencies = {"nvim-lua/plenary.nvim"}, tag = "0.1.8"}, {"ahmedkhalf/project.nvim", config = _14_}})
