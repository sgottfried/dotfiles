vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')
vim.cmd('syntax enable')

require("gruvbox").setup({
    contrast = "hard"
})


vim.cmd([[ hi! TermCursor guifg=NONE guibg=#ebdbb2 gui=NONE cterm=NONE ]])
vim.cmd([[ hi! TermCursorNC guifg=#ebdbb2 guibg=#3c3836 gui=NONE cterm=NONE ]])
