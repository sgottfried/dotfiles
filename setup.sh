ln -svf `echo $PWD`/vim/.vimrc ~
mkdir ~/.vim
git clone https://github.com/k-takata/minpac.git \
    ~/.vim/pack/minpac/opt/minpac
ln -svf `echo $PWD`/vim/packages.vim ~/.vim/packages.vim
ln -svf `echo $PWD`/tmux/.tmux.conf ~ 

ln -svf `echo $PWD`/git_template ~/.git_template
git config --global init.templatedir '~/.git_template'

echo "alias gst='git status'" >> ~/.bash_profile
echo "alias gdt='git difftool'" >> ~/.bash_profile
echo "alias gd='git diff'" >> ~/.bash_profile
echo "alias be='bundle exec'" >> ~/.bash_profile
echo "alias update_all='brew update && brew upgrade && vim +PackUpdate +qall'" >> ~/.bash_profile
echo "alias rubytags='ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)'" >> ~/.bash_profile
echo "alias jstags='ctags -R node_modules'" >> ~/.bash_profile
