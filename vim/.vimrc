source ~/.vim/packages.vim

syntax enable
set autoindent
set colorcolumn=110
set cursorline
set dir=~/.vim/tmp
set encoding=utf8
set expandtab "use spaces instead of tabs
set grepprg=ag\ --nogroup\ --nocolor
set hls
set incsearch
set list listchars=tab:▸\ ,eol:¬
set mouse=a
set number
set previewheight=10
set smartcase
set splitbelow
set swapfile
set t_Co=256
set tabstop=2 softtabstop=2 shiftwidth=2

colorscheme solarized

let mapleader = ","
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:airline_powerline_fonts = 1
"Mappings
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <Leader>c :copen<CR>
map <Leader>n :vs .<CR>
map <Leader>p :CtrlPMixed<CR>
map <Leader>w :w<CR>

autocmd FileType ruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby let g:rubycomplete_rails = 1
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript.jsx setlocal omnifunc=javascriptcomplete#CompleteJS

