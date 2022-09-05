-- Gruvbox Theme --
vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')
vim.cmd('syntax enable')
vim.g.lightline = {
  colorscheme = 'gruvbox',
  separator = {
    left = '\u{e0b0}',
    right = '\u{e0b2}'
  },
  subseperator = {
    left = '\u{e0b1}',
    right = '\u{e0b3}'
  }
}
