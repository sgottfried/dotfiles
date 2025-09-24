(import-macros {: if-work? } "config.macros")

(local lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim))
(var chat-model "claude-3.5-sonnet")
(if-work?
  (set chat-model "claude-sonnet-4"))

(when (not (vim.loop.fs_stat lazypath))
  (vim.fn.system [:git
                   :clone
                   "--filter=blob:none"
                   "https://github.com/folke/lazy.nvim.git"
                   :--branch=stable
                   lazypath]))
(vim.opt.rtp:prepend lazypath)

((. (require :lazy) :setup) [
                             ;; Core Dependencies
                             {1 :nvim-tree/nvim-web-devicons
                             :lazy true}
                             {1 :nvim-lua/plenary.nvim
                             :lazy true}

                             ;; Theme and UI
                             {1 :ellisonleao/gruvbox.nvim
                             :config true
                             :priority 1000}
                             {1 :nvim-lualine/lualine.nvim
                             :event :VeryLazy
                             :config (fn [])
                             :dependencies [:nvim-web-devicons]}
                             {1 :folke/which-key.nvim
                             :event :VeryLazy
                             :keys [{1 :<leader>?
                                       2 (fn [] ((. (require :which-key) :show) {:global false}))
                                       :desc "Buffer Local Keymaps (which-key)"}]}

                             ;; Git integration
                             {1 :airblade/vim-gitgutter
                             :event [:BufRead :BufNewFile]}
                             {1 :APZelos/blamer.nvim
                             :event [:BufRead :BufNewFile]}
                             {1 :tpope/vim-fugitive
                             :cmd [:Git :G]}

                             ;; LSP and Completion
                             {1 :neovim/nvim-lspconfig
                             :event :BufReadPre}
                             {1 :hrsh7th/nvim-cmp
                             :event :InsertEnter
                             :dependencies [:hrsh7th/cmp-nvim-lsp]}
                             {1 :williamboman/mason.nvim
                             :cmd :Mason}
                             {1 :creativenull/efmls-configs-nvim
                             :version :v1.x.x
                             :event :BufReadPre}

                             ;; Language and Syntax
                             {1 :HiPhish/rainbow-delimiters.nvim
                             :event [:BufReadPost :BufNewFile]}
                             {1 :nvim-treesitter/nvim-treesitter
                             :event [:BufReadPost :BufNewFile]
                             :build ":TSUpdate"}
                             {1 :ianks/vim-tsx
                             :ft [:typescript.tsx :javascript.jsx]}
                             {1 :leafgarland/typescript-vim
                             :ft [:typescript :javascript]}
                             {1 :pangloss/vim-javascript
                             :ft :javascript}
                             {1 :Olical/nfnl
                             :ft :fennel
                             :config (fn [])}
                             {1 :Olical/conjure
                             :ft [:fennel]
                             :dependencies [:PaterJason/cmp-conjure]
                             :init (fn [] (set vim.g.conjure#debug true))}

                             ;; Editor Enhancement
                             {1 :tpope/vim-commentary
                             :event [:BufRead :BufNewFile]}
                             {1 :tpope/vim-surround
                             :event [:BufRead :BufNewFile]}
                             {1 :tpope/vim-unimpaired
                             :event :VeryLazy}
                             {1 :tpope/vim-projectionist
                             :event :VeryLazy}
                             {1 :windwp/nvim-autopairs
                             :event :InsertEnter
                             :opts {}}
                             {1 :stevearc/oil.nvim
                             :cmd :Oil
                             :dependencies [:nvim-web-devicons]}

                             ;; AI Integration
                             {1 :github/copilot.vim
                             :event :InsertEnter}
                             {1 :CopilotC-Nvim/CopilotChat.nvim
                             :build "make tiktoken"
                             :config (fn [] ((. (require :CopilotChat) :setup) {:model chat-model}))
                             :cmd :CopilotChat
                             :dependencies [:github/copilot.vim :plenary.nvim]}

                             ;; Notes and Organization
                             {1 :nvim-neorg/neorg
                             :dependencies [:plenary.nvim]
                             :cmd :Neorg
                             :opts {:load {:core.concealer {}
                             :core.defaults {}
                             :core.dirman {:config {:default_workspace :journal
                             :workspaces {:journal "~/notes"}}}
                             :core.integrations.treesitter {}
                             :core.journal {:config {:workspace :journal}}
                             :core.qol.todo_items {}
                             :core.ui {}}}}

                             ;; Debugging
                             {1 :mfussenegger/nvim-dap
                             :cmd [:DapContinue :DapToggleBreakpoint]
                             :config (fn []
                                       ((. (require :mason-nvim-dap) :setup) {:ensure_installed [:js-debug-adapter]})
                                       (local dap (require :dap))
                                       (set dap.adapters.pwa-node
                                            {:executable {:args [(.. (vim.fn.stdpath :data)
                                                                     :/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js)
                                                                 :9229]
                                            :command :node}
                                            :host :localhost
                                            :port 9229
                                            :type :server})
                                       (each [_ language (ipairs [:javascript
                                                                   :javascript.jsx
                                                                   :typescript
                                                                   :typescript.tsx])]
                                         (tset dap.configurations language
                                               [{:console :integratedTerminal
                                                          :internalConsoleOptions :neverOpen
                                                          :name "Debug Jest Tests"
                                                          :request :launch
                                                          :runtimeArgs [:--inspect-brk
                                                                         "${workspaceFolder}/node_modules/.bin/jest"
                                                                         :--runInBand
                                                                         :--no-cache]
                                                          :runtimeExecutable :node
                                                          :type :pwa-node}]))
                                       ((. (require :dapui) :setup)))
                             :dependencies [:rcarriga/nvim-dap-ui
                                             :jay-babu/mason-nvim-dap.nvim]}

                             ;; Testing
                             {
                             1 :nvim-neotest/neotest
                             :dependencies [
                                            :nvim-neotest/nvim-nio
                                            :nvim-lua/plenary.nvim
                                            :antoinemadec/FixCursorHold.nvim
                                            :nvim-treesitter/nvim-treesitter
                                            :nvim-neotest/neotest-jest
                                            ]
                             :config (fn []
                                       ((. (require :neotest) :setup) {
                                          :adapters [
                                                     ((require "neotest-jest") {
                                                                               :jestCommand "npx jest"
                                                                               :jestArguments (fn [defaultArguments context]
                                                                                                defaultArguments
                                                                                                )
                                                                               :jestConfigFile :jest.config.ts
                                                                               :cwd (fn [path]
                                                                                      (vim.fn.getcwd)
                                                                                      )
                                                                               :isTestFile (. (require :neotest-jest.jest-util) :defaultIsTestFile)
                                                                               })
                                                     ]
                                          })) }
                             ;; Misc
                             {1 :folke/snacks.nvim
                             :event :VeryLazy
                             :opts {:image {}
                             :picker {}}}
                             ])
