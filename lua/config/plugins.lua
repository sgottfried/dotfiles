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
  return require("which-key").show({global = false})
end
local function _5_()
end
local function _6_()
  vim.g["conjure#debug"] = true
  return nil
end
local function _7_()
  return require("CopilotChat").setup({model = chat_model})
end
local function _8_()
  require("mason-nvim-dap").setup({ensure_installed = {"js-debug-adapter"}})
  local dap = require("dap")
  dap.adapters["pwa-node"] = {executable = {args = {(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"), "9229"}, command = "node"}, host = "localhost", port = 9229, type = "server"}
  for _, language in ipairs({"javascript", "javascript.jsx", "typescript", "typescript.tsx"}) do
    dap.configurations[language] = {{console = "integratedTerminal", internalConsoleOptions = "neverOpen", name = "Debug Jest Tests", request = "launch", runtimeArgs = {"--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest", "--runInBand", "--no-cache"}, runtimeExecutable = "node", type = "pwa-node"}}
  end
  return require("dapui").setup()
end
return require("lazy").setup({{"nvim-tree/nvim-web-devicons", lazy = true}, {"nvim-lua/plenary.nvim", lazy = true}, {"ellisonleao/gruvbox.nvim", config = true, priority = 1000}, {"nvim-lualine/lualine.nvim", event = "VeryLazy", config = _3_, dependencies = {"nvim-web-devicons"}}, {"folke/which-key.nvim", event = "VeryLazy", keys = {{"<leader>?", _4_, desc = "Buffer Local Keymaps (which-key)"}}}, {"airblade/vim-gitgutter", event = {"BufRead", "BufNewFile"}}, {"APZelos/blamer.nvim", event = {"BufRead", "BufNewFile"}}, {"tpope/vim-fugitive", cmd = {"Git", "G"}}, {"neovim/nvim-lspconfig", event = "BufReadPre"}, {"hrsh7th/nvim-cmp", event = "InsertEnter", dependencies = {"hrsh7th/cmp-nvim-lsp"}}, {"williamboman/mason.nvim", cmd = "Mason"}, {"creativenull/efmls-configs-nvim", version = "v1.x.x", event = "BufReadPre"}, {"HiPhish/rainbow-delimiters.nvim", event = {"BufReadPost", "BufNewFile"}}, {"nvim-treesitter/nvim-treesitter", event = {"BufReadPost", "BufNewFile"}, build = ":TSUpdate"}, {"ianks/vim-tsx", ft = {"typescript.tsx", "javascript.jsx"}}, {"leafgarland/typescript-vim", ft = {"typescript", "javascript"}}, {"pangloss/vim-javascript", ft = "javascript"}, {"Olical/nfnl", ft = "fennel", config = _5_}, {"Olical/conjure", ft = {"fennel"}, dependencies = {"PaterJason/cmp-conjure"}, init = _6_}, {"tpope/vim-commentary", event = {"BufRead", "BufNewFile"}}, {"tpope/vim-surround", event = {"BufRead", "BufNewFile"}}, {"tpope/vim-unimpaired", event = "VeryLazy"}, {"tpope/vim-projectionist", event = "VeryLazy"}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}}, {"stevearc/oil.nvim", cmd = "Oil", dependencies = {"nvim-web-devicons"}}, {"github/copilot.vim", event = "InsertEnter"}, {"CopilotC-Nvim/CopilotChat.nvim", build = "make tiktoken", config = _7_, cmd = "CopilotChat", dependencies = {"github/copilot.vim", "plenary.nvim"}}, {"nvim-neorg/neorg", dependencies = {"plenary.nvim"}, cmd = "Neorg", opts = {load = {["core.concealer"] = {}, ["core.defaults"] = {}, ["core.dirman"] = {config = {default_workspace = "journal", workspaces = {journal = "~/notes"}}}, ["core.integrations.treesitter"] = {}, ["core.journal"] = {config = {workspace = "journal"}}, ["core.qol.todo_items"] = {}, ["core.ui"] = {}}}}, {"mfussenegger/nvim-dap", cmd = {"DapContinue", "DapToggleBreakpoint"}, config = _8_, dependencies = {"rcarriga/nvim-dap-ui", "jay-babu/mason-nvim-dap.nvim"}}, {"folke/snacks.nvim", event = "VeryLazy", opts = {image = {}, picker = {}}}})
