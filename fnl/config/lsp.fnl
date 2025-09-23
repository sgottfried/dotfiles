(var capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities
     ((. (require :cmp_nvim_lsp) :default_capabilities) capabilities))
(fn on-attach [client bufnr]
  (fn buf-set-keymap [...] (vim.api.nvim_buf_set_keymap bufnr ...))

  (local opts {:noremap true :silent true})
  (buf-set-keymap :n :<leader>a "<Cmd>lua vim.lsp.buf.code_action()<CR>" opts)
  (buf-set-keymap :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" opts)
  (buf-set-keymap :n :gh "<Cmd>lua vim.lsp.buf.hover()<CR>" opts)
  (buf-set-keymap :n :ge "<Cmd>lua vim.diagnostic.open_float()<CR>" opts)
  (buf-set-keymap :n :gr "<cmd>lua vim.lsp.buf.references()<CR>" opts)
  (buf-set-keymap :n :gR "<cmd>lua vim.lsp.buf.rename()<CR>" opts))
(local servers [:bashls :cssls :jsonls :terraformls])
(each [_ lsp (ipairs servers)]
  (tset vim.lsp.config lsp {: capabilities :on_attach on-attach})
  (vim.lsp.enable lsp))
(set vim.lsp.config.tailwindcss {
      : capabilities
      :filetypes [:html
                   :javascript
                   :typescript
                   :javascriptreact
                   :typescriptreact
                   :javascript.jsx
                   :typescript.tsx]
      :init_options {:userLanguages {:javascript {:jsx :javascript}
      :typescript {:tsx :javascript}}}
      :on_attach on-attach})
(vim.lsp.enable :tailwindcss)
(set vim.lsp.config.ts_ls {
     : capabilities
     :on_attach (fn [client bufnr]
                  (when client.config.flags
                    (set client.config.flags.allow_incremental_sync
                         true))
                  (set client.server_capabilities.document_formatting
                       false)
                  (set client.server_capabilities.document_range_formatting
                       false)
                  (on-attach client bufnr))
     })
(vim.lsp.enable :ts_ls)
(local eslint (require :efmls-configs.linters.eslint_d))
(local prettier (require :efmls-configs.formatters.prettier_d))
(local languages {:javascript [eslint prettier]
       :javascript.jsx [eslint prettier]
       :typescript [eslint prettier]
       :typescript.tsx [eslint prettier]})
(local efmls-config
       {:filetypes (vim.tbl_keys languages)
       :init_options {:documentFormatting true :documentRangeFormatting true}
       :settings {: languages :rootMarkers [:.git/]}})
(set vim.lsp.config.efm efmls-config)
(vim.lsp.enable :efm)
(set vim.lsp.config.lua_ls {: capabilities
     :on_attach on-attach
     :settings {:Lua {:diagnostics {:globals [:vim]}
     :runtime {:version :LuaJIT}
     :telemetry {:enable false}
     :workspace {:checkThirdParty false
     :library (vim.api.nvim_get_runtime_file ""
                                             true)}}}})
(vim.lsp.enable :lua_ls)
(local fennel-config
        {
        :cmd [ "fennel-language-server" ]
        :filetypes [ "fennel" ]
        :single_file_support true
        :settings {
        :fennel {
        :workspace {
        :library (vim.api.nvim_list_runtime_paths)
        :checkThirdParty false
        }
        :diagnostics {
        :globals [ "vim" ]
        }}
        }
        :on_attach (fn [client bufnr]
                     (set client.server_capabilities.document_formatting
                          true)
                     (set client.server_capabilities.document_range_formatting
                          true)
                     (on-attach client bufnr)
                     )})
(set vim.lsp.config.fennel_language_server fennel-config)
(vim.lsp.enable :fennel_language_server)
((. (require :mason) :setup))	
