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
local servers = { "bashls", "cssls", "jsonls", "terraformls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

nvim_lsp.tailwindcss.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "javascript.jsx",
        "typescript.tsx" },
}

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

require("mason").setup()
