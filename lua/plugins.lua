vim.pack.add({
  -- Core/UI
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/sainnhe/gruvbox-material',

  -- Git
  'https://github.com/airblade/vim-gitgutter',
  'https://github.com/APZelos/blamer.nvim',

  -- LSP and Completion
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/creativenull/efmls-configs-nvim',
  'https://github.com/mfussenegger/nvim-lint',

  -- Syntax
  'https://github.com/HiPhish/rainbow-delimiters.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',

  -- Editor
  'https://github.com/tpope/vim-commentary',
  'https://github.com/tpope/vim-surround',
  'https://github.com/tpope/vim-unimpaired',
  'https://github.com/tpope/vim-projectionist',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/stevearc/oil.nvim',

  -- AI
  'https://github.com/github/copilot.vim',

  -- Misc
  'https://github.com/folke/snacks.nvim',

  -- Markdown
  'https://github.com/YousefHadder/markdown-plus.nvim',
})

require("markdown_agenda").setup({
  notes_dir = vim.fn.expand("~/notes"),
  include_done = false,
})

require('oil').setup({
  columns = {
    "icon",
    "size",
    "mtime",
    "permissions"
  }
})

-- Plugin configurations
require('nvim-autopairs').setup({})

require('snacks').setup({
  image = {},
  picker = {
    layout = { preview = false, preset = "ivy_split" }
  }
})

require('lint').linters_by_ft = {
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  javascriptreact = { 'eslint' },
  typescriptreact = { 'eslint' },
}

require("markdown-plus").setup()
