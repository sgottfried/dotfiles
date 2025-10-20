require('nvim-treesitter.configs').setup({
  auto_install = false,
  ensure_installed = {
    'vimdoc',
    'javascript',
    'typescript',
    'tsx',
    'lua',
    'java',
    'hcl',
    'fennel'
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  sync_install = false
})
