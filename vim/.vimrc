source ~/.vim/packages.vim

filetype plugin indent on
syntax enable
set autoindent
set colorcolumn=110
set cursorline
set dir=~/.vim/tmp
set encoding=utf8
set expandtab "use spaces instead of tabs
set incsearch
set list listchars=tab:▸\ ,eol:¬
set mouse=a
set number
set previewheight=10
set smartcase
set splitbelow
set swapfile
set tabstop=2 softtabstop=2 shiftwidth=2
set laststatus=2
set statusline=%f%=%{FugitiveHead()}\ \ \ %y\ [%P][%l:%c]
set shell=/bin/bash\ --login
set hidden

let mapleader = ","
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:github_enterprise_urls = ['https://git.xogrp.com']
let test#strategy = "dispatch"

set bg=light
colorscheme solarized

if has('nvim')
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=#cc241d guifg=white ctermbg=1 ctermfg=15
endif


"Mappings
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <Leader>c :copen<CR>
map <Leader>g :Gstatus<CR>
map <Leader>n :vs .<CR>
map <Leader>p :<C-u>Files<CR>
map <Leader>w :w<CR>
nnoremap <Leader>s :Grepper -tool ag<CR>
map <Leader>gb :BCommits<CR>
nmap <silent> <Leader>t :TestNearest<CR>
nmap <silent> <Leader>f :TestFile<CR>
nmap <silent> <Leader>a :TestSuite<CR>

inoremap hh <C-x><C-o>

tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

autocmd FileType ruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby let g:rubycomplete_rails = 1
autocmd FileType ruby nmap <Leader>d :Dispatch bundle exec rspec %<CR>
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript.jsx setlocal omnifunc=javascriptcomplete#CompleteJS

if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"
endif

autocmd TermOpen * setlocal nonumber norelativenumber
