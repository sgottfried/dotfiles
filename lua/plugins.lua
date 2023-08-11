local packer = require('packer')

packer.startup(function(use)
  use 'APZelos/blamer.nvim'
  use 'airblade/vim-gitgutter'
  use 'ellisonleao/gruvbox.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'ianks/vim-tsx'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'leafgarland/typescript-vim'
  use 'mxw/vim-jsx'
  use 'neovim/nvim-lspconfig'
  use 'pangloss/vim-javascript'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use 'wbthomason/packer.nvim'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }}
  use { 'nvim-telescope/telescope.nvim', requires = {{ "nvim-telescope/telescope-live-grep-args.nvim" }},
    config = function()
      require('telescope').load_extension('live_grep_args')
    end
  }
  use { 'nvim-lualine/lualine.nvim', requires = {{ 'kyazdani42/nvim-web-devicons', opt = true }},
    config = function()
      require('lualine').setup({})
    end
  }
  use {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers",
    requires = "nvim-lua/plenary.nvim",
    config = function()
        require('neorg').setup {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.integrations.treesitter"] = {},
                ["core.concealer"] = {
                    config = {
                        icon_preset = "diamond",
                        icons = {
                            todo = {
                                done = {
                                    icon = '✓'
                                },
                                pending = {
                                    icon = '□'
                                }
                            }
                        }
                    }
                }, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = 'notes'
                    },
                },
            },
        }
    end
}
end)
