My Neovim, VSCode-Neovim, and Kitty terminal configs.
  
### Get Started
Install [Kitty](https://sw.kovidgoyal.net/kitty/binary/).

Install Neovim
```
brew install neovim
```

Symlink dotfiles to where these applications will look for them:
               
```
ln -s <dotfiles_location>/init.lua ~/.config/nvim/init.lua
ln -s <dotfiles_location>/lua ~/.config/nvim/lua

ln -s <dotfiles_location>/kitty/kitty.conf ~/.config/kitty/kitty.conf   
ln -s <dotfiles_location>/kitty/theme.conf ~/.config/kitty/theme.conf
```

For Eslint and Prettier, you have to install EFM langserver, eslint_d (daemon for quickly running eslint), and prettierd (the same for prettier).

```
brew install efm-langserver
npm install -g eslint_d
npm install -g @fsouza/prettierd
```
                  
### Optional
- Install [VSCode-neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim).
- Set Neovim path in VSCode settings.json.
    
```
"vscode-neovim.neovimExecutablePaths.darwin": "/usr/local/bin/nvim",
```

                        
