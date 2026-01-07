My Neovim and Wezterm terminal configs.
  
### Get Started
Install [Ghostty](https://ghostty.org/).

Install Neovim
```
brew install neovim
```

Install lazygit
```
brew install lazygit
brew install git-delta
```

Symlink dotfiles to where these applications will look for them:
               
```
ln -s <dotfiles_location>/init.lua ~/.config/nvim/init.lua
ln -s <dotfiles_location>/lua ~/.config/nvim/lua

ln -s <dotfiles_location>/tmux.conf ~/.tmux.conf
ln -s <dotfiles_location>/ghostty.conf ~/config/ghostty/config
ln -s ~/workspace/dotfiles/lazygit.yml ~/Library/Application\ Support/lazygit/config.yml
```

For Eslint and Prettier, you have to install EFM langserver, eslint_d (daemon for quickly running eslint), and prettierd (the same for prettier).

```
brew install efm-langserver
npm install -g eslint_d
npm install -g @fsouza/prettierd
```
                  
