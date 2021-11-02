command! PackUpdate packadd minpac | source $MYVIMRC | redraw | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

packadd minpac

if exists('g:loaded_minpac')
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('SirVer/ultisnips')
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('honza/vim-snippets')
  call minpac#add('hrsh7th/nvim-cmp')
  call minpac#add('hrsh7th/cmp-nvim-lsp')
  call minpac#add('ianks/vim-tsx')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('junegunn/fzf')
  call minpac#add('leafgarland/typescript-vim')
  call minpac#add('mhinz/vim-grepper')
  call minpac#add('morhetz/gruvbox')
  call minpac#add('mxw/vim-jsx')
  call minpac#add('neovim/nvim-lspconfig')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-projectionist')
  call minpac#add('tpope/vim-rhubarb')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-vinegar')
endif

filetype plugin indent on
syntax enable
set autoindent
set cursorline
set dir=~/.vim/tmp
set encoding=utf8
set expandtab
set hidden
set hlsearch
set incsearch
set laststatus=2
set list listchars=tab:▸\ ,eol:¬
set mouse=a
set noshowmode
set number
set smartcase
set swapfile
set tabstop=2 softtabstop=2 shiftwidth=2

let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let mapleader = ","
set termguicolors
colorscheme gruvbox
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \}
hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

" autocmd BufWritePre *.js*,*.ts* OrganizeImports
" autocmd BufWritePre *.js*,*.ts* lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd TermOpen * setlocal nonumber norelativenumber nolist

inoremap <silent><expr> <C-y> compe#confirm('<CR>')
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Leader>b :botright split \| 10winc - \| b zsh<CR>
nnoremap <leader>c :copen<CR>
nnoremap <leader>d :Gvdiff<CR>
nnoremap <leader>p :FZF<CR>
nnoremap <leader>s :GrepperRg -g '!**/**test*' -i 
nnoremap <leader>t :call jobsend(3, "make run test=" . expand("%") . "\<lt>cr>")<CR>
" nnoremap <leader>t :exe "silent !tmux send -t 0.1 'make run test=%' Enter"<CR>
nnoremap <leader>w :w<CR>
tnoremap <Esc> <C-\><C-n> 

luafile ~/.config/nvim/luaconfig.lua
