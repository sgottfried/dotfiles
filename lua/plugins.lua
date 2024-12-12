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
    'ellisonleao/gruvbox.nvim',
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
    { 'github/copilot.vim', cond = vim.env.NEOVIM_INSTALL_COPILOT == 'true' },
    { "NeogitOrg/neogit",
        cmd = "Neogit",
        dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim", },
        config = true },
    { "folke/which-key.nvim", event = "VeryLazy",
        keys = { { "<leader>?", function() require("which-key").show({ global = false }) end,
            desc = "Buffer Local Keymaps (which-key)", }, }, },
    {
        "nvim-neorg/neorg",
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        opts = {
            load = { ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.integrations.treesitter"] = {},
                ["core.integrations.telescope"] = {},
                ["core.journal"] = { config = { workspace = "journal", } },
                ["core.dirman"] = { config = { default_workspace = "journal", workspaces = { journal = "~/notes" }, }, },
                ["core.qol.todo_items"] = {}, ["core.ui"] = {}, }
        },
        dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
    },
    { "nvim-neotest/neotest",
        dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter", "nvim-neotest/neotest-jest" },
        config = function() require('neotest').setup({ adapters = { require('neotest-jest')({ cwd = function(path) return vim
                    .fn.getcwd()
            end, }), } })
        end },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", },
    { "vhyrro/luarocks.nvim", priority = 1000, config = true },
    { 'creativenull/efmls-configs-nvim', version = 'v1.x.x', },
    { 'nvim-lualine/lualine.nvim', dependencies = { { 'kyazdani42/nvim-web-devicons', opt = true } },
        config = function() require('lualine').setup({ options = { theme = 'gruvbox', },
                sections = { lualine_c = { "filename",
                    function() return require("nvim-treesitter").statusline({ indicator_size = 100,
                            type_patterns = { "class", "function", "method", "pair" }, separator = " -> ", })
                    end, },
                    lualine_x = { "encoding", { "fileformat", symbols = { unix = "" } }, "filetype" }, }, })
        end },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.3', cmd = "Telescope" },
    { 'stevearc/oil.nvim', dependencies = { "nvim-tree/nvim-web-devicons" }, },
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
})
