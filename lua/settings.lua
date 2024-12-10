vim.g.copilot_filetypes = { norg = false }
vim.g.blamer_date_format = '%m/%d/%y'
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_visual_modes = 0
vim.g.jsx_ext_required = false
vim.g.mapleader = ' '
vim.o.autoindent = true
vim.o.completeopt = 'menuone,noselect'
vim.o.cursorline = true
vim.o.dir = os.getenv('HOME') .. '/.vim/tmp'
vim.o.encoding = 'utf8'
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.laststatus = 3
vim.o.mouse = 'a'
vim.o.number = true
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.softtabstop = 4
vim.o.swapfile = true
vim.o.tabstop = 4
vim.opt.path:append "**"
vim.opt.path:remove "/usr/include"
vim.opt.wildignore:append "**/.git/*"
vim.opt.wildignore:append "**/node_modules/*"
vim.opt.wildignorecase = true
