-- Plugins --
function PackInit()
  -- Minpac --
  vim.cmd('packadd minpac')

  vim.call('minpac#init')
  local add = vim.fn['minpac#add']

  add('k-takata/minpac', {type = 'opt'})

  -- Other Plugins --
  add('SirVer/ultisnips')
  add('RRethy/nvim-base16')
  add('airblade/vim-gitgutter')
  add('ellisonleao/gruvbox.nvim')
  add('honza/vim-snippets')
  add('hrsh7th/cmp-nvim-lsp')
  add('hrsh7th/nvim-cmp')
  add('ianks/vim-tsx')
  add('itchyny/lightline.vim')
  add('junegunn/fzf')
  add('k-takata/minpac')
  add('kyazdani42/nvim-web-devicons')
  add('leafgarland/typescript-vim')
  add('lifepillar/vim-solarized8')
  add('mxw/vim-jsx')
  add('neovim/nvim-lspconfig')
  add('nvim-lua/plenary.nvim')
  add('nvim-telescope/telescope.nvim')
  add('pangloss/vim-javascript')
  add('pwntester/octo.nvim')
  add('quangnguyen30192/cmp-nvim-ultisnips')
  add('tpope/vim-commentary')
  add('tpope/vim-fugitive')
  add('tpope/vim-projectionist')
  add('tpope/vim-rhubarb')
  add('tpope/vim-surround')
  add('tpope/vim-unimpaired')
  add('tpope/vim-vinegar')
end

-- Define user commands for updating/cleaning the plugins.
-- Each of them calls PackInit() to load minpac and register
-- the information of plugins, then performs the task.
vim.cmd [[
  command! PackUpdate lua PackInit(); vim.call('minpac#update')
  command! PackClean  lua PackInit(); vim.call('minpac#clean')
]]
-- Settings --
vim.cmd([[ highlight TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE ]])
vim.cmd('filetype plugin indent on')
vim.cmd([[ set listchars=tab:▸\ ,eol:¬]])
vim.g.jsx_ext_required = false
vim.g.mapleader = ','
vim.o.autoindent = true
vim.o.cursorline = true
vim.o.dir = [[~/.vim/tmp]]
vim.o.encoding = 'utf8'
vim.o.completeopt = 'menuone,noselect'
vim.o.expandtab = true
vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
vim.o.grepprg = 'rg --vimgrep --smart-case'
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.laststatus = 3
vim.o.mouse = 'a'
vim.o.number = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.swapfile = true
vim.o.tabstop = 2

-- Gruvbox Theme --
vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')
vim.cmd('syntax enable')
vim.g.lightline = {
  colorscheme = 'gruvbox',
  separator = {
    left = '\u{e0b0}',
    right = '\u{e0b2}'
  },
  subseperator = {
    left = '\u{e0b1}',
    right = '\u{e0b3}'
  }
}

-- Auto Commands --
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  command = 'silent! EslintFixAll'
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = { '[^l]*'},
  nested = true,
  command = vim.cmd('cwindow')
})

vim.api.nvim_create_autocmd('Filetype', {
  pattern = {'gitcommit', 'gitrebase', 'gitconfig'},
  callback = function() vim.opt.bufhidden='delete' end
})

-- End Settings --

local function run_test()
  local filename = vim.fn.expand('%')
  vim.cmd([[!kitty @ send-text -m id:2 yarn test ]] .. filename .. [[\\x0d]])
  -- Run in Tmux pane --
  -- vim.cmd('!tmux send -t 0.1 \'yarn test ' .. filename .. '\' Enter')
  -- Run in Docker --
  -- vim.cmd([[!kitty @ send-text -m id:2 make run test=]] .. filename .. [[\\x0d]])
end

-- Keymaps --
local default_opts = { remap = false }
vim.keymap.set('n', '<C-h>', '<C-w>h', default_opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', default_opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', default_opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', default_opts)
vim.keymap.set('n', '<leader>c', ':copen<CR>', default_opts)
vim.keymap.set('n', '<leader>d', ':Gvdiff<CR>', default_opts)
vim.keymap.set('n', '<leader>p', ':FZF<CR>', default_opts)
vim.keymap.set('n', '<leader>s', ":grep -g '!**/**test*' -i ", default_opts)
vim.keymap.set('n', '<leader>t', run_test, default_opts)
vim.keymap.set('n', '<leader>w', ':w<CR>', default_opts)
vim.keymap.set('n', '<leader>W', ':noa w<CR>', default_opts)

-- nvim-cmp setup
local cmp = require 'cmp'

if(cmp ~= nil) then
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-y>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
    }, {
      { name = 'buffer' },
    }),
  })
end

-- Add additional LSP capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- LSP SETUP --
local nvim_lsp = require('lspconfig')

-- This is run every time a language server is connected
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  print("'" .. client.name .. "' language server started" );
end

-- Sets up all language servers (aside from tsserver and sumneko_lua)
-- with the on_attach from above and the capabilities from nvim-cmp (completion)
local servers = { "bashls", "cssls", "cssmodules_ls", "dockerls", "eslint", "jsonls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

-- Sets up tsserver with the on_attach from above, the capabilities from nvim-cmp (completion),
-- a root directory that contains `.git`, and the ability to organize imports.
nvim_lsp.tsserver.setup{
  on_attach = function(client, bufnr)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern(".git"),
}

-- Sets up sumneko_lua language server for Lua/Neovim work
nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
