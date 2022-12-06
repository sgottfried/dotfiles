local packer = require('packer')

packer.startup(function(use)
  use 'tpope/vim-unimpaired'
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'SirVer/ultisnips'
  use 'airblade/vim-gitgutter'
  use 'ellisonleao/gruvbox.nvim'
  use 'honza/vim-snippets'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'ianks/vim-tsx'
  use 'junegunn/fzf'
  use 'leafgarland/typescript-vim'
  use 'mxw/vim-jsx'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }}
  use 'pangloss/vim-javascript'
  use { 'quangnguyen30192/cmp-nvim-ultisnips', requires = {{ 'hrsh7th/nvim-cmp'}}}
  use 'tpope/vim-fugitive'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-vinegar'
  use { 'nvim-telescope/telescope.nvim', requires = {{ "nvim-telescope/telescope-live-grep-args.nvim" }},
    config = function()
      require('telescope').load_extension('live_grep_args')
    end
  }
  use { 'nvim-lualine/lualine.nvim', requires = {{ 'kyazdani42/nvim-web-devicons', opt = true }}}
  use { 'KadoBOT/nvim-spotify', run = 'make',
  config = function()
    local spotify = require'nvim-spotify'

    spotify.setup {
      -- default opts
      status = {
        update_interval = 10000, -- the interval (ms) to check for what's currently playing
        format = '%s %t by %a' -- spotify-tui --format argument
      }
    }
  end }
end)
