My Neovim and Wezterm terminal configs.
  
### Get Started
Install [Wezterm](https://wezterm.org/index.html).

Install Neovim
```
brew install neovim
```

or for Emacs
```
brew install emacs-plus@30

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

ln -s /opt/homebrew/Cellar/emacs-plus@30/30.2/Emacs.app /Applications/Emacs.app
ln -s <dotfiles_location>/doom  ~/.config/doom
```

If vterm doesn't work in Emacs, see the following: https://github.com/akermu/emacs-libvterm/issues/471#issuecomment-1214274231

Install lazygit
```
brew install lazygit
brew install git-delta
```

Symlink dotfiles to where these applications will look for them:
               
```
ln -s <dotfiles_location>/init.lua ~/.config/nvim/init.lua
ln -s <dotfiles_location>/lua ~/.config/nvim/lua

ln -s <dotfiles_location>/wezterm.lua ~/.wezterm.lua
ln -s ~/workspace/dotfiles/lazygit.yml ~/Library/Application\ Support/lazygit/config.yml
```

For Eslint and Prettier, you have to install EFM langserver, eslint_d (daemon for quickly running eslint), and prettierd (the same for prettier).

```
brew install efm-langserver
npm install -g eslint_d
npm install -g @fsouza/prettierd
```
                  
