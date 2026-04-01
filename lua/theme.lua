vim.cmd(" hi! TermCursor guifg=NONE guibg=#ebdbb2 gui=NONE cterm=NONE ")
vim.cmd(" hi! TermCursorNC guifg=#ebdbb2 guibg=#3c3836 gui=NONE cterm=NONE ")
vim.cmd("colorscheme gruvbox-material")

require("lualine").setup({
  options = {
    theme = "gruvbox-material"
  },
  sections = {
    lualine_c = {
      "filename",
      function()
        local ts = require("nvim-treesitter")
        if ts and ts.statusline then
          return ts.statusline({
            indicator_size = 100,
            separator = " -> ",
            type_patterns = { "class", "function", "method", "pair" }
          })
        end
        return ""
      end
    },
    lualine_x = { "encoding", { "fileformat", symbols = { unix = "\238\156\145" } }, "filetype" }
  }
})
