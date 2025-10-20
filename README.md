My Neovim and Wezterm terminal configs.
  
### Get Started
Install [Wezterm](https://wezterm.org/index.html).

Install Neovim
```
brew install neovim
```

Symlink dotfiles to where these applications will look for them:
               
```
ln -s <dotfiles_location>/init.lua ~/.config/nvim/init.lua
ln -s <dotfiles_location>/lua ~/.config/nvim/lua

ln -s <dotfiles_location>/wezterm.lua ~/.wezterm.lua
```

For Eslint and Prettier, you have to install EFM langserver, eslint_d (daemon for quickly running eslint), and prettierd (the same for prettier).

```
brew install efm-langserver
npm install -g eslint_d
npm install -g @fsouza/prettierd
```
                  
