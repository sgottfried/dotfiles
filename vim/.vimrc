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
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \}

set termguicolors
colorscheme solarized8
"Change theme depending on the time of day
let hr = (strftime('%H'))
  if hr >= 18
  set background=dark
elseif hr >= 8
  set background=light
elseif hr >= 0
  set background=dark
endif

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

augroup LightlineColorscheme
  autocmd!
  autocmd ColorScheme * call s:lightline_update()
augroup END
function! s:lightline_update()
  if !exists('g:loaded_lightline')
    return
  endif
  try
    if g:colors_name =~# 'solarized'
      runtime autoload/lightline/colorscheme/solarized.vim
      call lightline#init()
      call lightline#colorscheme()
      call lightline#update()

      if &background == 'light'
        execute "silent !tmux source-file " . shellescape(expand('~/.tmux/plugins/tmux-colors-solarized/tmuxcolors-light.conf'))
      else
        execute "silent !tmux source-file " . shellescape(expand('~/.tmux/plugins/tmux-colors-solarized/tmuxcolors-dark.conf'))
      endif
    endif
  catch
  endtry
endfunction
