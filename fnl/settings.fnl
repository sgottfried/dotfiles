(set vim.g.copilot_filetypes {:norg false :org false})
(set vim.g.blamer_date_format "%m/%d/%y")
(set vim.g.blamer_enabled 1)
(set vim.g.blamer_show_in_visual_modes 0)
(set vim.g.jsx_ext_required false)
(set vim.g.mapleader " ")
(set vim.o.autoindent true)
(set vim.o.completeopt "menuone,noselect")
(set vim.o.cursorline true)
(set vim.o.dir (.. (os.getenv :HOME) :/.vim/tmp))
(set vim.o.encoding :utf8)
(set vim.o.expandtab true)
(set vim.o.hidden true)
(set vim.o.hlsearch false)
(set vim.o.incsearch true)
(set vim.o.laststatus 3)
(set vim.o.mouse :a)
(set vim.o.number true)
(set vim.o.shiftwidth 4)
(set vim.o.smartcase true)
(set vim.o.softtabstop 4)
(set vim.o.swapfile true)
(set vim.o.tabstop 4)
(vim.opt.path:append "**")
(vim.opt.path:remove :/usr/include)
(vim.opt.wildignore:append :**/.git/*)
(vim.opt.wildignore:append :**/node_modules/*)
(set vim.opt.wildignorecase true)
(set vim.opt.foldmethod :indent)
(set vim.opt.foldenable false)
(vim.diagnostic.config {:severity_sort true
                        :signs true
                        :underline true
                        :update_in_insert false
                        :virtual_text {:prefix "●" :spacing 4}})	
