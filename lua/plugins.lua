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
    'airblade/vim-gitgutter',
    'ellisonleao/gruvbox.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'ianks/vim-tsx',
    'jose-elias-alvarez/null-ls.nvim',
    'leafgarland/typescript-vim',
    'mxw/vim-jsx',
    'neovim/nvim-lspconfig',
    'pangloss/vim-javascript',
    'theHamsta/nvim-dap-virtual-text',
    'tpope/vim-commentary',
    'tpope/vim-fugitive',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',
    'tpope/vim-vinegar',
    { "rcarriga/nvim-dap-ui",            dependencies = { "mfussenegger/nvim-dap" } },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "mxsdev/nvim-dap-vscode-js",       dependencies = { "mfussenegger/nvim-dap" } },
    {
        'creativenull/efmls-configs-nvim',
        version = 'v1.x.x', -- version is optional, but recommended
        dependencies = { 'neovim/nvim-lspconfig' },
    },
    {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = {
            {
                'nvim-lua/plenary.nvim',
                "nvim-telescope/telescope-live-grep-args.nvim",
                -- This will not install any breaking changes.
                -- For major updates, this must be adjusted manually.
                version = "^1.0.0",
            },
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { { 'kyazdani42/nvim-web-devicons', opt = true } },
        config = function()
            require('lualine').setup({})
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    -- ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.dirman"] = {     -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                            default_workspace = 'notes'
                        },
                    },
                },
            }
        end,
    },
})
