-- Gruvbox Theme --
vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')
vim.cmd('syntax enable')

require("gruvbox").setup({
    contrast="hard"
})

