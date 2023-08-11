vim.g.blamer_enabled = 1
vim.g.blamer_show_in_visual_modes = 0
vim.g.blamer_date_format = '%m/%d/%y'
vim.g.jsx_ext_required = false
vim.o.autoindent = true
vim.o.completeopt = 'menuone,noselect'
vim.o.cursorline = true
vim.o.encoding = 'utf8'
vim.o.expandtab = true
vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
vim.o.grepprg = 'rg --vimgrep --smart-case'
vim.o.hidden = true
vim.o.laststatus = 3
vim.o.mouse = 'a'
vim.o.number = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.swapfile = true
vim.o.tabstop = 4
vim.opt.path:remove "/usr/include"
vim.opt.path:append "**"
vim.opt.wildignorecase = true
vim.opt.wildignore:append "**/node_modules/*"
vim.opt.wildignore:append "**/.git/*"
