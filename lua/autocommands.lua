-- Autocommands --
local function run_test_js()
  local filename = vim.fn.expand('%')
  -- Run in Kitty terminal
  vim.cmd([[!kitty @ send-text -m id:2 yarn test ]] .. filename .. [[\\x0d]])
  -- Run in Tmux pane --
  -- vim.cmd('!tmux send -t 0.1 \'yarn test ' .. filename .. '\' Enter')
  -- Run in Docker --
  -- vim.cmd([[!kitty @ send-text -m id:2 make run test=]] .. filename .. [[\\x0d]])
end

local function run_test_rb()
  local filename = vim.fn.expand('%')
  -- Run in Kitty terminal
  vim.cmd([[!kitty @ send-text -m id:2 rspec ]] .. filename .. [[\\x0d]])
end

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  command = 'silent! EslintFixAll'
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = { '[^l]*'},
  nested = true,
  command = vim.cmd('cwindow')
})

vim.api.nvim_create_autocmd('Filetype', {
  pattern = {'gitcommit', 'gitrebase', 'gitconfig'},
  callback = function() vim.opt.bufhidden='delete' end
})

vim.api.nvim_create_autocmd('Filetype', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  callback = function()
    vim.keymap.set('n', '<leader>t', run_test_js, { remap = false })
  end
})

vim.api.nvim_create_autocmd('Filetype', {
  pattern = {'ruby'},
  callback = function()
    vim.keymap.set('n', '<leader>t', run_test_rb, { remap = false })
  end
})


vim.api.nvim_create_autocmd('TermOpen', {
  pattern = {'*'},
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end
})
