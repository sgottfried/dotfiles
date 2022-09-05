require('plugins')
require('common')

if vim.g.vscode then
  print('Loading VSCode-Neovim config')
  require('vscode')
else
  print('Loading Neovim config')
  require('settings')
  require('theme')
  require('keybindings')
  require('autocommands')
  require('lsp')
  require('completion')
end
