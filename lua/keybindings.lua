-- keybindings --
local default_opts = { remap = false }
vim.keymap.set('n', '<C-h>', '<C-w>h', default_opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', default_opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', default_opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', default_opts)
vim.keymap.set('n', '<leader>c', ':copen<CR>', default_opts)
vim.keymap.set('n', '<leader>d', ':Gvdiff<CR>', default_opts)
vim.keymap.set('n', '<leader>p', ':FZF<CR>', default_opts)
vim.keymap.set('n', '<leader>s', ":grep -g '!**/**test*' -i ", default_opts)
vim.keymap.set('n', '<leader>w', ':w<CR>', default_opts)
vim.keymap.set('n', '<leader>W', ':noa w<CR>', default_opts)
