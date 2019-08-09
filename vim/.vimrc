source ~/.vim/packages.vim

filetype plugin indent on
syntax enable

" Settings
set autoindent
set cursorline
set dir=~/.vim/tmp
set encoding=utf8
set expandtab
set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m,%f:%l:%m
set hidden
set incsearch
set laststatus=2
set mouse=a
set number
set smartcase
set statusline=%f%=%{FugitiveHead()}\ \ \ %y\ [%P][%l:%c]
set swapfile
set tabstop=2 softtabstop=2 shiftwidth=2

let g:ale_linters = {'javascript': ['eslint'], 'ruby': ['rubocop']}
let g:gitgutter_override_sign_column_highlight = 0
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:netrw_banner = 0
let mapleader = ","
colorscheme solarized
set background=light

"Mappings
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Leader>c :copen<CR>
nnoremap <Leader>d :Gvdiff<CR>
nnoremap <Leader>n :Vex<CR>
nnoremap <Leader>p :FZF<CR>
nnoremap <Leader>s :grep -g '!**/test*' 
nnoremap <Leader>w :w<CR>
nnoremap [Q :cfirst<CR>
nnoremap [q :cprevious<CR>
nnoremap ]Q :clast<CR>
nnoremap ]q :cnext<CR>

highlight clear SignColumn

"Change cursor shape in insert mode
let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[0 q\033\\"

" Graveyard

" nnoremap <Leader>b :botright split \| b zsh<CR>
" nnoremap <Leader>f :TestFile<CR>
" nnoremap <Leader>l :TestLast<CR>
" nnoremap <Leader>r :Rg<CR>
" nnoremap <Leader>t :TestNearest<CR>
" nnoremap gh :call CocAction('doHover')<CR>
" tnoremap <Esc> <C-\><C-n>
"
" let test#ruby#rspec#executable = 'docker-compose exec app rspec'
" let test#strategy = "dispatch"
" let g:lightline = {
"   \ 'colorscheme': 'solarized',
" \ }

