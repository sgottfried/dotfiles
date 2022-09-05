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

Install [Packer](https://github.com/wbthomason/packer.nvim) for Neovim dependencies.
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Run `:PackerInstall` in Neovim.
                  
### Optional
- Install [VSCode-neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim).
- Set Neovim path in VSCode settings.json.
    
```
"vscode-neovim.neovimExecutablePaths.darwin": "/usr/local/bin/nvim",
```

                        
