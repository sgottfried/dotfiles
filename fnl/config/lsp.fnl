(local capabilities ((. (require :cmp_nvim_lsp) :default_capabilities) 
                    (vim.lsp.protocol.make_client_capabilities)))

(fn on-attach [client bufnr]
  (fn buf-set-keymap [...] (vim.api.nvim_buf_set_keymap bufnr ...))
  (local opts {:noremap true :silent true})
  (buf-set-keymap :n :<leader>a "<Cmd>lua vim.lsp.buf.code_action()<CR>" opts)
  (buf-set-keymap :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" opts)
  (buf-set-keymap :n :gh "<Cmd>lua vim.lsp.buf.hover()<CR>" opts)
  (buf-set-keymap :n :ge "<Cmd>lua vim.diagnostic.open_float()<CR>" opts)
  (buf-set-keymap :n :gr "<cmd>lua vim.lsp.buf.references()<CR>" opts)
  (buf-set-keymap :n :gR "<cmd>lua vim.lsp.buf.rename()<CR>" opts))

(local base-config {: capabilities : on-attach})

;; Simple servers configuration
(local simple-servers [:bashls :cssls :jsonls :terraformls])
(each [_ server (ipairs simple-servers)]
  (tset vim.lsp.config server base-config)
  (vim.lsp.enable server))

;; Tailwind configuration
(let [tailwind-config (vim.tbl_extend "force" base-config
                       {:filetypes [:html :javascript :typescript 
                                  :javascriptreact :typescriptreact
                                  :javascript.jsx :typescript.tsx]
                        :init_options {:userLanguages 
                                     {:javascript {:jsx :javascript}
                                      :typescript {:tsx :javascript}}}})]
  (tset vim.lsp.config :tailwindcss tailwind-config)
  (vim.lsp.enable :tailwindcss))

;; TypeScript configuration
(let [ts-config (vim.tbl_extend "force" base-config
                 {:on-attach (fn [client bufnr]
                             (when client.config.flags
                               (set client.config.flags.allow_incremental_sync true))
                             (set client.server_capabilities.document_formatting false)
                             (set client.server_capabilities.document_range_formatting false)
                             (on-attach client bufnr))})]
  (tset vim.lsp.config :ts_ls ts-config)
  (vim.lsp.enable :ts_ls))

;; EFM configuration
(let [eslint (require :efmls-configs.linters.eslint_d)
      prettier (require :efmls-configs.formatters.prettier_d)
      languages {:javascript [eslint prettier]
                :javascript.jsx [eslint prettier]
                :typescript [eslint prettier]
                :typescript.tsx [eslint prettier]}
      efm-config {:filetypes (vim.tbl_keys languages)
                 :init_options {:documentFormatting true 
                              :documentRangeFormatting true}
                 :settings {: languages :rootMarkers [:.git/]}}]
  (tset vim.lsp.config :efm efm-config)
  (vim.lsp.enable :efm))

;; Lua LSP configuration
(let [lua-config (vim.tbl_extend "force" base-config
                  {:settings {:Lua {:diagnostics {:globals [:vim]}
                                  :runtime {:version :LuaJIT}
                                  :telemetry {:enable false}
                                  :workspace {:checkThirdParty false
                                            :library (vim.api.nvim_get_runtime_file "" true)}}}})]
  (tset vim.lsp.config :lua_ls lua-config)
  (vim.lsp.enable :lua_ls))

;; Fennel LSP configuration
(let [fennel-config (vim.tbl_extend "force" base-config
                     {:cmd [:fennel-language-server]
                      :filetypes [:fennel]
                      :single_file_support true
                      :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)
                                                    :checkThirdParty false}
                                        :diagnostics {:globals [:vim]}}}
                      :on-attach (fn [client bufnr]
                                 (set client.server_capabilities.document_formatting true)
                                 (set client.server_capabilities.document_range_formatting true)
                                 (on-attach client bufnr))})]
  (tset vim.lsp.config :fennel_language_server fennel-config)
  (vim.lsp.enable :fennel_language_server))

;; Initialize mason
((. (require :mason) :setup))
