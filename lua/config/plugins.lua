-- [nfnl] fnl/config/plugins.fnl
local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
local chat_model = "claude-3.5-sonnet"
if (os.getenv("NEOVIM_ENVIRONMENT") == "work") then
  chat_model = "claude-sonnet-4"
else
end
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
else
end
vim.opt.rtp:prepend(lazypath)
local function _3_()
end
local function _4_()
  return require("CopilotChat").setup({model = chat_model})
end
local function _5_()
  return require("which-key").show({global = false})
end
local function _6_()
  require("mason-nvim-dap").setup({ensure_installed = {"js-debug-adapter"}})
  local dap = require("dap")
  dap.adapters["pwa-node"] = {executable = {args = {(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"), "9229"}, command = "node"}, host = "localhost", port = 9229, type = "server"}
  for _, language in ipairs({"javascript", "javascript.jsx", "typescript", "typescript.tsx"}) do
    dap.configurations[language] = {{console = "integratedTerminal", internalConsoleOptions = "neverOpen", name = "Debug Jest Tests", request = "launch", runtimeArgs = {"--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest", "--runInBand", "--no-cache"}, runtimeExecutable = "node", type = "pwa-node"}}
  end
  return require("dapui").setup()
end
local function _7_()
end
local function _8_()
  vim.g["conjure#debug"] = true
  return nil
end
return require("lazy").setup({"APZelos/blamer.nvim", "HiPhish/rainbow-delimiters.nvim", "airblade/vim-gitgutter", "github/copilot.vim", "hrsh7th/cmp-nvim-lsp", "hrsh7th/nvim-cmp", "ianks/vim-tsx", "leafgarland/typescript-vim", "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim", "pangloss/vim-javascript", "tpope/vim-commentary", "tpope/vim-fugitive", "tpope/vim-projectionist", "tpope/vim-surround", "tpope/vim-unimpaired", {"williamboman/mason.nvim", lazy = true, cmd = "Mason"}, {"Olical/nfnl", ft = "fennel", config = _3_}, {"CopilotC-Nvim/CopilotChat.nvim", build = "make tiktoken", config = _4_, lazy = true, cmd = "CopilotChat", dependencies = {{"github/copilot.vim"}, {"nvim-lua/plenary.nvim", branch = "master"}}}, {"ellisonleao/gruvbox.nvim", config = true, priority = 1000}, {"folke/which-key.nvim", event = "VeryLazy", keys = {{"<leader>?", _5_, desc = "Buffer Local Keymaps (which-key)"}}}, {"nvim-neorg/neorg", dependencies = {{"nvim-lua/plenary.nvim"}}, cmd = "Neorg", lazy = true, opts = {load = {["core.concealer"] = {}, ["core.defaults"] = {}, ["core.dirman"] = {config = {default_workspace = "journal", workspaces = {journal = "~/notes"}}}, ["core.integrations.treesitter"] = {}, ["core.journal"] = {config = {workspace = "journal"}}, ["core.qol.todo_items"] = {}, ["core.ui"] = {}}}, version = "*"}, {"mfussenegger/nvim-dap", cmd = "DapContinue", lazy = true, config = _6_, dependencies = {"rcarriga/nvim-dap-ui", "jay-babu/mason-nvim-dap.nvim"}}, {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}, {"creativenull/efmls-configs-nvim", version = "v1.x.x"}, {"nvim-lualine/lualine.nvim", config = _7_, dependencies = {{"kyazdani42/nvim-web-devicons", opt = true}}}, {"stevearc/oil.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}}, {"Olical/conjure", ft = {"fennel"}, lazy = true, dependencies = {{"PaterJason/cmp-conjure"}}, init = _8_}, {"folke/snacks.nvim", opts = {image = {}, picker = {}}}})
