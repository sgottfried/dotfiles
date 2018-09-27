command! PackUpdate packadd minpac | source $MYVIMRC | redraw | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

if !exists('*minpac#init')
  finish
endif

call minpac#init()

call minpac#add('k-takata/minpac', {'type':'opt'})

call minpac#add('altercation/vim-colors-solarized')
call minpac#add('edkolev/tmuxline.vim')
call minpac#add('honza/vim-snippets')
call minpac#add('kien/ctrlp.vim')
call minpac#add('SirVer/ultisnips')
call minpac#add('ternjs/tern_for_vim')
call minpac#add('tpope/vim-bundler')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-rbenv')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-vinegar')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
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
