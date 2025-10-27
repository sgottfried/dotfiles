require("plugins")
require("settings")
require("theme")
require("keybindings")
require("autocommands")
require("lsp")
require("completion")
require("treesitter")
require("gtd")
require("meetings")
require('oil').setup({
  columns = {
    "icon",
    "size",
    "mtime",
    "permissions"
  }
})
