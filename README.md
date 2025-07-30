My Neovim and Wezterm terminal configs.
Note: Configs are in [Fennel](https://fennel-lang.org/), a Lisp dialect that compiles to Lua.
  
### Get Started
Install [Wezterm](https://wezterm.org/index.html).

Install Neovim
```
brew install neovim
```

Symlink dotfiles to where these applications will look for them:
               
```
ln -s <dotfiles_location>/init.lua ~/.config/nvim/init.lua
ln -s <dotfiles_location>/init.fnl ~/.config/nvim/init.fnl
ln -s <dotfiles_location>/fnl ~/.config/nvim/fnl

ln -s <dotfiles_location>/wezterm.fnl ~/.wezterm.fnl
```

For Eslint and Prettier, you have to install EFM langserver, eslint_d (daemon for quickly running eslint), and prettierd (the same for prettier).

```
brew install efm-langserver
npm install -g eslint_d
npm install -g @fsouza/prettierd
```
                  
