-- [nfnl] fnl/config/treesitter.fnl
return require("nvim-treesitter.configs").setup({ensure_installed = {"vimdoc", "javascript", "typescript", "tsx", "lua", "java", "hcl", "fennel"}, highlight = {enable = true, additional_vim_regex_highlighting = false}, auto_install = false, sync_install = false})
