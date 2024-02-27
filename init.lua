-- Plugins --
-- get lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    'APZelos/blamer.nvim',
    'airblade/vim-gitgutter',
    'ellisonleao/gruvbox.nvim',
    'github/copilot.vim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'ianks/vim-tsx',
    'jose-elias-alvarez/null-ls.nvim',
    'leafgarland/typescript-vim',
    'mxw/vim-jsx',
    'neovim/nvim-lspconfig',
    'pangloss/vim-javascript',
    'theHamsta/nvim-dap-virtual-text',
    'tpope/vim-commentary',
    'tpope/vim-fugitive',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',
    'tpope/vim-vinegar',
    { "rcarriga/nvim-dap-ui",            dependencies = { "mfussenegger/nvim-dap" } },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "mxsdev/nvim-dap-vscode-js",       dependencies = { "mfussenegger/nvim-dap" } },
    {
        'creativenull/efmls-configs-nvim',
        version = 'v1.x.x', -- version is optional, but recommended
        dependencies = { 'neovim/nvim-lspconfig' },
    },
    {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = {
            {
                'nvim-lua/plenary.nvim',
                "nvim-telescope/telescope-live-grep-args.nvim",
                -- This will not install any breaking changes.
                -- For major updates, this must be adjusted manually.
                version = "^1.0.0",
            },
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { { 'kyazdani42/nvim-web-devicons', opt = true } },
        config = function()
            require('lualine').setup({})
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        -- tag = "*",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},  -- Loads default behaviour
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.dirman"] = {      -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                        },
                    },
                    ["core.ui"] = {},
                    -- ["core.tempus"] = {},
                    -- ["core.ui.calendar"] = {}
                },
            }
        end,
    },
})

-- Settings --
vim.g.blamer_date_format = '%m/%d/%y'
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_visual_modes = 0
vim.g.jsx_ext_required = false
vim.g.mapleader = ' '
vim.o.autoindent = true
vim.o.completeopt = 'menuone,noselect'
vim.o.cursorline = true
vim.o.dir = os.getenv('HOME') .. '/.vim/tmp'
vim.o.encoding = 'utf8'
vim.o.expandtab = true
vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
vim.o.grepprg = 'rg --vimgrep --smart-case'
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.laststatus = 3
vim.o.mouse = 'a'
vim.o.number = true
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.softtabstop = 4
vim.o.swapfile = true
vim.o.tabstop = 4
vim.opt.path:append "**"
vim.opt.path:remove "/usr/include"
vim.opt.wildignore:append "**/.git/*"
vim.opt.wildignore:append "**/node_modules/*"
vim.opt.wildignorecase = true

-- Treesitter setup

require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "vimdoc", "javascript", "typescript", "lua" },


    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

-- Gruvbox Theme --
vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')
vim.cmd('syntax enable')

require("gruvbox").setup({
    contrast = "hard"
})

vim.cmd([[ hi! TermCursor guifg=NONE guibg=#ebdbb2 gui=NONE cterm=NONE ]])
vim.cmd([[ hi! TermCursorNC guifg=#ebdbb2 guibg=#3c3836 gui=NONE cterm=NONE ]])

-- keybindings --
local telescope = require('telescope.builtin')
local default_opts = { remap = false }
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<C-h>', '<C-w>h', default_opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', default_opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', default_opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', default_opts)
vim.keymap.set('n', '<leader><space>', telescope.find_files, default_opts)
vim.keymap.set('n', '<leader>B', ':bnext<CR>', default_opts)
vim.keymap.set('n', '<leader>D', ':DapContinue<CR>', default_opts)
vim.keymap.set('n', '<leader>S', ":grep -g '!**/**test*' -i ", default_opts)
vim.keymap.set('n', '<leader>W', ':noa w<CR>', default_opts)
vim.keymap.set('n', '<leader>b', ':bprevious<CR>', default_opts)
vim.keymap.set('n', '<leader>c', ':copen<CR>', default_opts)
vim.keymap.set('n', '<leader>d', ':Gvdiff<CR>', default_opts)
vim.keymap.set('n', '<leader>s', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", default_opts)
vim.keymap.set('n', '<leader>t', ':belowright sp | b zsh<CR>', default_opts)
vim.keymap.set('n', '<leader>w', ':w<CR>', default_opts)
vim.keymap.set('n', '<leader>h', '<C-w>h', default_opts)
vim.keymap.set('n', '<leader>j', '<C-w>j', default_opts)
vim.keymap.set('n', '<leader>k', '<C-w>k', default_opts)
vim.keymap.set('n', '<leader>l', '<C-w>l', default_opts)
vim.keymap.set('n', '<leader>H', '<C-w>H', default_opts)
vim.keymap.set('n', '<leader>J', '<C-w>J', default_opts)
vim.keymap.set('n', '<leader>K', '<C-w>K', default_opts)
vim.keymap.set('n', '<leader>L', '<C-w>L', default_opts)
vim.keymap.set('n', '<leader>wo', ':only<CR>', default_opts)
vim.keymap.set('n', '<leader>ws', ':sp<CR>', default_opts)
vim.keymap.set('n', '<leader>wv', ':vs<CR>', default_opts)
vim.keymap.set('n', '<leader>;', telescope.commands, default_opts)
vim.keymap.set('n', 'Y', '"+y', default_opts)
vim.keymap.set('n', 'gD', ":lua require('dapui').toggle()<CR>", default_opts)
vim.keymap.set('n', 'gb', ':DapToggleBreakpoint<CR>', default_opts)
vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], default_opts)
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], default_opts)
vim.keymap.set('v', 'Y', '"+y', default_opts)

-- Autocommands --
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        vim.lsp.buf.format()
    end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    pattern = { '[^l]*' },
    nested = true,
    command = vim.cmd('cwindow')
})

vim.api.nvim_create_autocmd('Filetype', {
    pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
    callback = function() vim.opt.bufhidden = 'delete' end
})

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = { '*' },
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
    end
})

-- LSP --
-- Add additional LSP capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- LSP SETUP --
local nvim_lsp = require('lspconfig')

-- This is run every time a language server is connected
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', '<leader>a', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('v', '<leader>a', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

-- Sets up all language servers (aside from tsserver and lua_ls)
-- with the on_attach from above and the capabilities from nvim-cmp (completion)
local servers = { "bashls", "cssls", "jsonls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

-- Sets up tsserver with the on_attach from above, the capabilities from nvim-cmp (completion),
-- a root directory that contains `.git`, and the ability to organize imports.
nvim_lsp.tsserver.setup {
    on_attach = function(client, bufnr)
        if client.config.flags then
            client.config.flags.allow_incremental_sync = true
        end
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false

        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern(".git"),
}

local eslint = require('efmls-configs.linters.eslint_d')
local prettier = require('efmls-configs.formatters.prettier_d')
local languages = {
    typescript = { eslint, prettier },
    javascript = { eslint, prettier },
    ['javascript.jsx'] = { eslint, prettier },
    ['typescript.tsx'] = { eslint, prettier },
}


local efmls_config = {
    filetypes = vim.tbl_keys(languages),
    settings = {
        rootMarkers = { '.git/' },
        languages = languages,
    },
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
    },
}

require('lspconfig').efm.setup(efmls_config)

-- Sets up lua_ls language server for Neovim work
nvim_lsp.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

-- Autocomplete --
local cmp = require 'cmp'

if (cmp ~= nil) then
    cmp.setup({
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
        snippet = { expand = function() end },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
        }),
    })

    vim.cmd [[
        set completeopt=menuone,noinsert,noselect
        highlight! default link CmpItemKind CmpItemMenuDefault
    ]]
end

-- Debugging --
local dap, dapui = require("dap"), require("dapui")
dapui.setup()

require("nvim-dap-virtual-text").setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

require("dap-vscode-js").setup({
    adapters = { 'pwa-node' }
})

local js_filetypes = { 'javascript', 'javascript.jsx', 'typescript', 'typescript.tsx', 'cucumber' }
for _, language in ipairs(js_filetypes) do
    require("dap").configurations[language] = {
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            runtimeExecutable = "node",
            runtimeArgs = {
                "./node_modules/jest/bin/jest.js",
                "--config",
                "jest.ui.config.js",
                "--setupFiles",
                "dotenv/config"
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
        },
        {
            name = "Cucumber: @debug",
            type = "pwa-node",
            request = "launch",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            env = {
                BROWSER = "mobile"
            },
            runtimeArgs = {
                "${workspaceFolder}/node_modules/@cucumber/cucumber/bin/cucumber-js",
                "--tags",
                "@debug",
                "--config",
                "./cucumber-debug.js"
            },
            cwd = "${workspaceFolder}"
        }
    }
end

-- Telescope setup --
local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup {
    defaults = { file_ignore_patterns = { "node_modules" } },
    extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- override default mappings
            -- default_mappings = {},
            mappings = { -- extend mappings
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt({ postfix = [[ -g '!**/**test*' -i]] })

                }
            }
        }
    }
}
