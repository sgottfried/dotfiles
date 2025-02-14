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
    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('telescope').load_extension('projects')
            require('project_nvim').setup {}
        end
    },
    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {},
        dependencies = {
            "kiyoon/magick.nvim",
        }
    },
    { 'glacambre/firenvim', build = ":call firenvim#install(0)" },
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim", },
        config = true
    },
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
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = { '~/notes/*work.org', '~/notes/personal.norg', '~/notes/beorg/**/*.org' },
                org_todo_keywords = { 'START', 'TODO', 'WAIT', '|', 'DONE', 'CANCELED' }
            })
        end,
    },
    { 'akinsho/org-bullets.nvim', config = function() require('org-bullets').setup() end },
    {
        "nvim-neotest/neotest",
        dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter", "nvim-neotest/neotest-jest" },
        config = function()
            require('neotest').setup({
                adapters = { require('neotest-jest')({
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
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", },
    { "vhyrro/luarocks.nvim", priority = 1000, config = true },
    { 'creativenull/efmls-configs-nvim', version = 'v1.x.x', },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { { 'kyazdani42/nvim-web-devicons', opt = true } },
        config = function()
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-media-files.nvim"
        }
    },
    { 'stevearc/oil.nvim', dependencies = { "nvim-tree/nvim-web-devicons" }, },
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
})
