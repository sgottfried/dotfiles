-- Autocommands --
local function run_test_js()
  local filename = vim.fn.expand('%')
  -- Run in Kitty terminal
  vim.cmd([[!kitty @ send-text -m id:2 npx mocha -r @babel/register -r dotenv/config ]] .. filename .. [[\\x0d]])
  -- Run in Neovim terminal split
  -- vim.cmd([[:call chansend(3, "yarn test ]] .. filename .. [[\n") ]])
  -- Run in Tmux pane --
  -- vim.cmd('!tmux send -t 0.1 \'yarn test ' .. filename .. '\' Enter')
  -- Run in Docker --
  -- vim.cmd([[!kitty @ send-text -m id:2 make run test=]] .. filename .. [[\\x0d]])
end

local function run_all_tests_js()
  vim.cmd([[!kitty @ send-text -m id:2 npm run test \\x0d]])
end

local function debug_test_js()
  local filename = vim.fn.expand('%')
  vim.cmd([[!kitty @ send-text -m id:2 yarn test:debug ]] .. filename .. [[\\x0d]])
end

vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
  pattern = { '*/node_modules/*' },
  command = 'lua vim.diagnostic.disable(0)'
})

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
    vim.keymap.set('n', '<leader>A', run_all_tests_js, { remap = false })
    vim.keymap.set('n', '<leader>t', run_test_js, { remap = false })
    vim.keymap.set('n', '<leader>T', debug_test_js, { remap = false })
  end
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = {'*'},
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end
})
