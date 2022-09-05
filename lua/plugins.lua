local packer = require('packer')
local is_not_vscode = function ()
  return vim.g.vscode == nil
end

packer.startup(function(use)
  use 'tpope/vim-commentary'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-surround'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'neovim/nvim-lspconfig'
  use 'ellisonleao/gruvbox.nvim'

  use { 'SirVer/ultisnips', cond = is_not_vscode }
  use { 'airblade/vim-gitgutter', cond = is_not_vscode }
  use { 'honza/vim-snippets', cond = is_not_vscode }
  use { 'ianks/vim-tsx', cond = is_not_vscode }
  use { 'itchyny/lightline.vim', cond = is_not_vscode }
  use { 'junegunn/fzf', cond = is_not_vscode }
  use { 'leafgarland/typescript-vim', cond = is_not_vscode }
  use { 'mxw/vim-jsx', cond = is_not_vscode }
  use { 'nvim-lua/plenary.nvim', cond = is_not_vscode }
  use { 'nvim-telescope/telescope.nvim', cond = is_not_vscode }
  use { 'pangloss/vim-javascript', cond = is_not_vscode }
  use { 'quangnguyen30192/cmp-nvim-ultisnips', cond = is_not_vscode }
  use { 'tpope/vim-fugitive', cond = is_not_vscode }
  use { 'tpope/vim-projectionist', cond = is_not_vscode }
  use { 'tpope/vim-rhubarb', cond = is_not_vscode }
end)
