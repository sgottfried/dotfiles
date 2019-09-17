source ~/.vim/packages.vim

filetype plugin indent on
syntax enable

" Settings
set autoindent
set cursorline
set dir=~/.vim/tmp
set encoding=utf8
set expandtab
set hidden
set incsearch
set laststatus=2
set mouse=a
set noshowmode
set number
set smartcase
set swapfile
set tabstop=2 softtabstop=2 shiftwidth=2
set wildignorecase
set wildmenu
set wildmode=list:longest,full

let g:ale_linters = {'javascript': ['eslint'], 'ruby': ['rubocop']}
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let mapleader = ","
let test#ruby#rspec#executable = 'docker-compose exec app rspec'
let test#strategy = "dispatch"

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=light
set termguicolors
colorscheme solarized8
let g:lightline = {}
let g:lightline.colorscheme = 'solarized'

"Mappings
inoremap hh <esc>
nnoremap gh :call CocAction('doHover')<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Leader>b :botright split \| b zsh<CR>
nnoremap <Leader>c :copen<CR>
nnoremap <Leader>d :Gvdiff<CR>
nnoremap <Leader>f :TestFile<CR>
nnoremap <Leader>l :TestLast<CR>
nnoremap <Leader>p :FZF<CR>
nnoremap <Leader>s :GrepperRg -g '!**/test*' -i 
nnoremap <Leader>t :TestNearest<CR>
nnoremap <Leader>w :w<CR>
tnoremap <Esc> <C-\><C-n> 

if exists('$TMUX')
  " tmux will only forward escape sequences to the terminal if surrounded
  " by a DCS sequence
  let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
  let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
  autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[0 q\033\\"
else
  let &t_SI .= "\<Esc>[6 q"
  let &t_EI .= "\<Esc>[2 q"
  autocmd VimLeave * silent !echo -ne "\033[0 q"
endi
