-- [nfnl] fnl/config/lsp.fnl
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local nvim_lsp = require("lspconfig")
local function on_attach(client, bufnr)
  local function buf_set_keymap(...)
    return vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = {noremap = true, silent = true}
  buf_set_keymap("n", "<leader>a", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gh", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "ge", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  return buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end
local servers = {"bashls", "cssls", "jsonls", "terraformls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({capabilities = capabilities, on_attach = on_attach})
end
nvim_lsp.tailwindcss.setup({capabilities = capabilities, filetypes = {"html", "javascript", "typescript", "javascriptreact", "typescriptreact", "javascript.jsx", "typescript.tsx"}, init_options = {userLanguages = {javascript = {jsx = "javascript"}, typescript = {tsx = "javascript"}}}, on_attach = on_attach})
local function _1_(client, bufnr)
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  else
  end
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
  return on_attach(client, bufnr)
end
nvim_lsp.ts_ls.setup({capabilities = capabilities, on_attach = _1_, root_dir = nvim_lsp.util.root_pattern(".git")})
local eslint = require("efmls-configs.linters.eslint_d")
local prettier = require("efmls-configs.formatters.prettier_d")
local languages = {javascript = {eslint, prettier}, ["javascript.jsx"] = {eslint, prettier}, typescript = {eslint, prettier}, ["typescript.tsx"] = {eslint, prettier}}
local efmls_config = {filetypes = vim.tbl_keys(languages), init_options = {documentFormatting = true, documentRangeFormatting = true}, settings = {languages = languages, rootMarkers = {".git/"}}}
require("lspconfig").efm.setup(efmls_config)
nvim_lsp.lua_ls.setup({capabilities = capabilities, on_attach = on_attach, settings = {Lua = {diagnostics = {globals = {"vim"}}, runtime = {version = "LuaJIT"}, telemetry = {enable = false}, workspace = {library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false}}}})
local fennel_config
local function _3_(client, bufnr)
  client.server_capabilities.document_formatting = true
  client.server_capabilities.document_range_formatting = true
  return on_attach(client, bufnr)
end
fennel_config = {cmd = {"fennel-language-server"}, filetypes = {"fennel"}, single_file_support = true, root_dir = require("lspconfig").util.root_pattern("fnl"), settings = {fennel = {workspace = {library = vim.api.nvim_list_runtime_paths(), checkThirdParty = false}, diagnostics = {globals = {"vim"}}}}, on_attach = _3_}
require("lspconfig").fennel_language_server.setup(fennel_config)
return require("mason").setup()
