-- Plugins --
-- get lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    'APZelos/blamer.nvim',
    'HiPhish/rainbow-delimiters.nvim',
    'airblade/vim-gitgutter',
    'dhruvasagar/vim-table-mode',
    'github/copilot.vim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'ianks/vim-tsx',
    'leafgarland/typescript-vim',
    'mfussenegger/nvim-jdtls',
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
    'pangloss/vim-javascript',
    'tpope/vim-commentary',
    'tpope/vim-projectionist',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',
    'williamboman/mason.nvim',
    {
        "folke/snacks.nvim",
        opts = {
            image = {},
            picker = {}
        }
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        config = function()
            require("CopilotChat").setup()
        end
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },

    {
        "f-person/auto-dark-mode.nvim",
        opts = {
            update_interval = 1000,
            set_dark_mode = function()
                vim.api.nvim_set_option_value("background", "dark", {})
                require('gruvbox').setup({ contrast = "hard" })
                vim.cmd("colorscheme gruvbox")
            end,
            set_light_mode = function()
                vim.api.nvim_set_option_value("background", "light", {})
                require('gruvbox').setup({ contrast = "hard" })
                vim.cmd("colorscheme gruvbox")
            end,
        },
    },
    { 'glacambre/firenvim', build = ":call firenvim#install(0)" },
    { 'tpope/vim-fugitive' },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = { {
            "<leader>?",
            function() require("which-key").show({ global = false }) end,
            desc = "Buffer Local Keymaps (which-key)",
        }, },
    },
    {
        "nvim-neorg/neorg",
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.integrations.treesitter"] = {},
                ["core.journal"] = { config = { workspace = "journal", } },
                ["core.dirman"] = { config = { default_workspace = "journal", workspaces = { journal = "~/notes" }, }, },
                ["core.qol.todo_items"] = {},
                ["core.ui"] = {},
            }
        },
        dependencies = { { "nvim-lua/plenary.nvim" } }
    },
    {
        "nvim-neotest/neotest",
        lazy = false,
        dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter", "nvim-neotest/neotest-jest" },
        config = function()
            require('neotest').setup({
                adapters = { require('neotest-jest')({
                    jestCommand = "npx jest",
                    cwd = function(path)
                        return vim
                            .fn.getcwd()
                    end,
                }), },
                icons = {
                    passed = "",
                    running = "",
                    failed = "",
                    unknown = ""
                }
            })
        end
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "jay-babu/mason-nvim-dap.nvim",


        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "js-debug-adapter" },
            })

            local dap = require("dap")
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = 9229,
                executable = {
                    command = "node",
                    args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
                        "9229" },
                },
            }
            for _, language in ipairs({ "javascript", "javascript.jsx", "typescript", "typescript.tsx" }) do
                dap.configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Debug Jest Tests",
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "--inspect-brk",
                            "${workspaceFolder}/node_modules/.bin/jest",
                            "--runInBand",
                            "--no-cache",
                        },
                        console = "integratedTerminal",
                        internalConsoleOptions = "neverOpen",
                    },
                }
            end

            require('dapui').setup()
        end,
    },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", },
    { "vhyrro/luarocks.nvim", priority = 1000, config = true },
    { 'creativenull/efmls-configs-nvim', version = 'v1.x.x', },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { { 'kyazdani42/nvim-web-devicons', opt = true } },
        config = function()
        end
    },
    { 'stevearc/oil.nvim', dependencies = { "nvim-tree/nvim-web-devicons" }, },
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
})
