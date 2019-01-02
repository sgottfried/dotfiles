command! PackUpdate packadd minpac | source $MYVIMRC | redraw | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" packadd! matchit

if !exists('*minpac#init')
  finish
endif

call minpac#init()

call minpac#add('k-takata/minpac', {'type':'opt'})

call minpac#add('altercation/vim-colors-solarized')
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('janko-m/vim-test')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('mhinz/vim-grepper')
call minpac#add('morhetz/gruvbox')
call minpac#add('radenling/vim-dispatch-neovim')
" call minpac#add('Shougo/deoplete.nvim')
call minpac#add('tpope/vim-bundler')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('tpope/vim-rbenv')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-vinegar')
call minpac#add('w0rp/ale')

"Git
call minpac#add('mhinz/vim-signify')
call minpac#add('tpope/vim-fugitive')

"languages
call minpac#add('kchmck/vim-coffee-script')
call minpac#add('pangloss/vim-javascript')
call minpac#add('moll/vim-node')
call minpac#add('mxw/vim-jsx')
call minpac#add('vim-ruby/vim-ruby')
