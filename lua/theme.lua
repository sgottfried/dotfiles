-- [nfnl] fnl/config/theme.fnl
vim.cmd("colorscheme retrobox")
vim.cmd(" hi! TermCursor guifg=NONE guibg=#ebdbb2 gui=NONE cterm=NONE ")
vim.cmd(" hi! TermCursorNC guifg=#ebdbb2 guibg=#3c3836 gui=NONE cterm=NONE ")
local function _1_()
  return require("nvim-treesitter").statusline({ indicator_size = 100, separator = " -> ",
    type_patterns = { "class", "function", "method", "pair" } })
end

require("lualine").setup({
  options = { theme = "gruvbox"},
  sections = {
    lualine_c = {
      "filename",
      function()
        require("nvim-treesitter").statusline({
          indicator_size = 100,
          separator = " -> ",
          type_patterns = { "class", "function", "method", "pair" }
        })
      end
    },
    lualine_x = { "encoding", { "fileformat", symbols = { unix = "\238\156\145" } }, "filetype" }
  }
})
