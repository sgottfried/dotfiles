vim.cmd([[ hi! TermCursor guifg=NONE guibg=#ebdbb2 gui=NONE cterm=NONE ]])
vim.cmd([[ hi! TermCursorNC guifg=#ebdbb2 guibg=#3c3836 gui=NONE cterm=NONE ]])

require('lualine').setup({
    options = { theme = 'gruvbox', },
    sections = {
        lualine_c = { "filename",
            function()
                return require("nvim-treesitter").statusline({
                    indicator_size = 100,
                    type_patterns = { "class", "function", "method", "pair" },
                    separator = " -> ",
                })
            end, },
        lualine_x = { "encoding", { "fileformat", symbols = { unix = "" } }, "filetype" },
    },
})
