local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true }
  local function map(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  map('n', '<leader>a', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', 'ge', '<Cmd>lua vim.diagnostic.open_float()<CR>')
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  map('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>')
end

local base_config = { capabilities = capabilities, on_attach = on_attach }

-- Simple servers configuration
local simple_servers = { 'bashls', 'cssls', 'jsonls', 'terraformls' }
for _, server in ipairs(simple_servers) do
  vim.lsp.config[server] = base_config
  vim.lsp.enable(server)
end

-- Tailwind configuration
local tailwind_config = vim.tbl_extend('force', base_config, {
  filetypes = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact',
    'javascript.jsx', 'typescript.tsx' },
  init_options = {
    userLanguages = {
      javascript = { jsx = 'javascript' },
      typescript = { tsx = 'javascript' }
    }
  }
})
vim.lsp.config.tailwindcss = tailwind_config
vim.lsp.enable('tailwindcss')

-- TypeScript configuration
local ts_config = vim.tbl_extend('force', base_config, {
  on_attach = function(client, bufnr)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    on_attach(client, bufnr)
  end
})
vim.lsp.config.ts_ls = ts_config
vim.lsp.enable('ts_ls')

vim.lsp.enable('eslint')

-- EFM configuration
local prettier = require('efmls-configs.formatters.prettier_d')
local languages = {
  javascript = { prettier },
  ['javascript.jsx'] = { prettier },
  typescript = { prettier },
  ['typescript.tsx'] = { prettier }
}
local efm_config = {
  filetypes = vim.tbl_keys(languages),
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true
  },
  settings = {
    languages = languages,
    rootMarkers = { '.git/' }
  }
}
vim.lsp.config.efm = efm_config
vim.lsp.enable('efm')

-- Lua LSP configuration
local lua_config = vim.tbl_extend('force', base_config, {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      runtime = { version = 'LuaJIT' },
      telemetry = { enable = false },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file('', true)
      }
    }
  }
})
vim.lsp.config.lua_ls = lua_config
vim.lsp.enable('lua_ls')
