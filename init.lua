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
    'HiPhish/rainbow-delimiters.nvim',
    'airblade/vim-gitgutter',
    'ellisonleao/gruvbox.nvim',
    'github/copilot.vim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'ianks/vim-tsx',
    'leafgarland/typescript-vim',
    'mfussenegger/nvim-jdtls',
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
    'pangloss/vim-javascript',
    'tpope/vim-commentary',
    'tpope/vim-projectionist',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-jest"
        },
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-jest')({
                        cwd = function(path)
                            return vim.fn.getcwd()
                        end,
                    }),
                }
            })
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed.
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true
    },
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true,   -- This automatically runs `require("luarocks-nvim").setup()`
    },
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim", "nvim-neorg/neorg-telescope" },
        -- put any other flags you wanted to pass to lazy here!
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},  -- Loads default behaviour
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.integrations.telescope"] = {},
                    ["core.journal"] = {
                        config = {
                            workspace = "journal",
                        }
                    },
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            default_workspace = "journal",
                            workspaces = {
                                journal = "~/notes"

                            },
                        },
                    },
                    ["core.qol.todo_items"] = {},
                    ["core.ui"] = {},
                },
            })
        end,
    },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", },
    {
        'creativenull/efmls-configs-nvim',
        version = 'v1.x.x', -- version is optional, but recommended
        dependencies = { 'neovim/nvim-lspconfig' },
    },
    { 'nvim-telescope/telescope.nvim',   tag = '0.1.3', },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { { 'kyazdani42/nvim-web-devicons', opt = true } },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'gruvbox',
                },
                sections = {
                    lualine_c = {
                        "filename",
                        function()
                            return require("nvim-treesitter").statusline({
                                indicator_size = 100,
                                type_patterns = { "class", "function", "method", "pair" },
                                separator = " -> ",
                            })
                        end,
                    },
                    lualine_x = { "encoding", { "fileformat", symbols = { unix = "" } },
                        "filetype" },
                },
            })
        end
    },
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
})


-- Settings --
vim.g.copilot_filetypes = { norg = false }
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
    ensure_installed = { "vimdoc", "javascript", "typescript", "tsx", "lua", "java" },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
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
local telescope_builtin = require('telescope.builtin')
local default_opts = { remap = false }

local wk = require("which-key")
wk.add({
    { "<leader>;",        ':',                          desc = "Run Command" },
    { "<leader><leader>", telescope_builtin.find_files, desc = "Find Files" },
    {
        "<leader>S",
        ':Telescope live_grep glob_pattern=!*{test,spec}.*<CR>',
        desc =
        "Search project (without tests)"
    },
    { "<leader>b",  group = "buffer" },
    {
        '<leader>bi',
        ':Telescope buffers<CR>',
        desc =
        "List buffers"
    },
    {
        '<leader>bS',
        ':noa w<CR>',
        desc =
        "Save (without formatting)"
    },
    { '<leader>bs', ':w<CR>',                             desc = "Save" },
    { "<leader>c",  ':copen<CR>',                         desc = "Open Quickfix" },
    { "<leader>g",  group = "Git" },
    { "<leader>gd", ':Neogit diff<CR>',                   desc = "Neogit Diff" },
    { "<leader>gg", ':Neogit<CR>',                        desc = "Open Neogit" },
    { "<leader>n",  ':Telescope neorg find_linkable<CR>', desc = "Find Neorg Heading" },
    {
        "<leader>s",
        ':Telescope live_grep<CR>',
        desc =
        "Search project"
    },
    { "<leader>t",  group = "Neotest" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "test file" },
    {
        "<leader>tt",
        function() require("neotest").run.run() end,
        desc =
        "run test under cursor"
    },
    {
        "<leader>tw",
        "<cmd>lua require('neotest').run.run({ jestCommand = 'npx jest --watch ' })<cr>",
        desc =
        "run test watch"
    },
    { "<leader>w", proxy = "<c-w>", group = "windows" },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', 'Y', '"+y', default_opts)
vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], default_opts)
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], default_opts)
vim.keymap.set('v', 'Y', '"+y', default_opts)

-- Autocommands --
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        vim.diagnostic.open_float()
    end
})
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

local insert_neorg_link = function()
    local link = vim.fn.input("Link: ")
    local text = vim.fn.input("Text: ")

    vim.api.nvim_set_current_line("{" .. link .. "}[" .. text .. "]")
end

local insert_markdown_link = function()
    local link = vim.fn.input("Link: ")
    local text = vim.fn.input("Text: ")

    vim.api.nvim_set_current_line("[" .. text .. "](" .. link .. ")")
end


vim.api.nvim_create_autocmd("Filetype", {
    pattern = "norg",
    callback = function()
        vim.keymap.set("n", "<leader>t", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { buffer = true })
        vim.keymap.set("i", "<C-l>", insert_neorg_link, { buffer = true })
    end,
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set("i", "<C-l>", insert_markdown_link, { buffer = true })
    end,
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
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'ge', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

-- Sets up all language servers (aside from ts_ls and lua_ls)
-- with the on_attach from above and the capabilities from nvim-cmp (completion)
local servers = { "bashls", "cssls", "jsonls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

-- Sets up ts_ls with the on_attach from above, the capabilities from nvim-cmp (completion),
-- a root directory that contains `.git`, and the ability to organize imports.
nvim_lsp.ts_ls.setup {
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

require("oil").setup()
