-- [nfnl] fnl/config/lsp.fnl
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
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
local base_config = {capabilities = capabilities, ["on-attach"] = on_attach}
local simple_servers = {"bashls", "cssls", "jsonls", "terraformls"}
for _, server in ipairs(simple_servers) do
  vim.lsp.config[server] = base_config
  vim.lsp.enable(server)
end
do
  local tailwind_config = vim.tbl_extend("force", base_config, {filetypes = {"html", "javascript", "typescript", "javascriptreact", "typescriptreact", "javascript.jsx", "typescript.tsx"}, init_options = {userLanguages = {javascript = {jsx = "javascript"}, typescript = {tsx = "javascript"}}}})
  vim.lsp.config["tailwindcss"] = tailwind_config
  vim.lsp.enable("tailwindcss")
end
do
  local ts_config
  local function _1_(client, bufnr)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    else
    end
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    return on_attach(client, bufnr)
  end
  ts_config = vim.tbl_extend("force", base_config, {["on-attach"] = _1_})
  vim.lsp.config["ts_ls"] = ts_config
  vim.lsp.enable("ts_ls")
end
do
  local eslint = require("efmls-configs.linters.eslint_d")
  local prettier = require("efmls-configs.formatters.prettier_d")
  local languages = {javascript = {eslint, prettier}, ["javascript.jsx"] = {eslint, prettier}, typescript = {eslint, prettier}, ["typescript.tsx"] = {eslint, prettier}}
  local efm_config = {filetypes = vim.tbl_keys(languages), init_options = {documentFormatting = true, documentRangeFormatting = true}, settings = {languages = languages, rootMarkers = {".git/"}}}
  vim.lsp.config["efm"] = efm_config
  vim.lsp.enable("efm")
end
do
  local lua_config = vim.tbl_extend("force", base_config, {settings = {Lua = {diagnostics = {globals = {"vim"}}, runtime = {version = "LuaJIT"}, telemetry = {enable = false}, workspace = {library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false}}}})
  vim.lsp.config["lua_ls"] = lua_config
  vim.lsp.enable("lua_ls")
end
do
  local fennel_config
  local function _3_(client, bufnr)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true
    return on_attach(client, bufnr)
  end
  fennel_config = vim.tbl_extend("force", base_config, {cmd = {"fennel-language-server"}, filetypes = {"fennel"}, single_file_support = true, settings = {fennel = {workspace = {library = vim.api.nvim_list_runtime_paths(), checkThirdParty = false}, diagnostics = {globals = {"vim"}}}}, ["on-attach"] = _3_})
  vim.lsp.config["fennel_language_server"] = fennel_config
  vim.lsp.enable("fennel_language_server")
end
return require("mason").setup()
