(local lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim))
(local chat-model (if (= (os.getenv "NEOVIM_ENVIRONMENT") "work")
                     "claude-4-sonnet"
                     "claude-3.5-sonnet"))
(when (not (vim.loop.fs_stat lazypath))
  (vim.fn.system [:git
                   :clone
                   "--filter=blob:none"
                   "https://github.com/folke/lazy.nvim.git"
                   :--branch=stable
                   lazypath]))
(vim.opt.rtp:prepend lazypath)
((. (require :lazy) :setup) [:APZelos/blamer.nvim
                              :HiPhish/rainbow-delimiters.nvim
                              :airblade/vim-gitgutter
                              :alnav3/sonarlint.nvim
                              :dhruvasagar/vim-table-mode
                              :github/copilot.vim
                              :hrsh7th/cmp-nvim-lsp
                              :hrsh7th/nvim-cmp
                              :ianks/vim-tsx
                              :leafgarland/typescript-vim
                              :mfussenegger/nvim-jdtls
                              :neovim/nvim-lspconfig
                              :nvim-lua/plenary.nvim
                              :nvim-telescope/telescope-ui-select.nvim
                              :pangloss/vim-javascript
                              :tpope/vim-commentary
                              :tpope/vim-fugitive
                              :tpope/vim-projectionist
                              :tpope/vim-surround
                              :tpope/vim-unimpaired
                              :williamboman/mason.nvim
                              { 1 :Olical/nfnl
                              :ft :fennel
                              :config (fn [])
                              }
                              {1 :CopilotC-Nvim/CopilotChat.nvim
                              :build "make tiktoken"
                              :config (fn []
                                        ((. (require :CopilotChat) :setup) {:model chat-model}))
                              :dependencies [[:github/copilot.vim]
                                             {1 :nvim-lua/plenary.nvim
                                             :branch :master}]}
                              {1 :ellisonleao/gruvbox.nvim
                              :config true
                              :priority 1000}
                              {1 :f-person/auto-dark-mode.nvim
                              :opts {:set_dark_mode (fn []
                                                      (vim.api.nvim_set_option_value :background
                                                                                     :dark
                                                                                     {})
                                                      ((. (require :gruvbox)
                                                          :setup) {:contrast :hard})
                                                      (vim.cmd "colorscheme gruvbox"))
                              :set_light_mode (fn []
                                                (vim.api.nvim_set_option_value :background
                                                                               :light
                                                                               {})
                                                ((. (require :gruvbox)
                                                    :setup) {:contrast :hard})
                                                (vim.cmd "colorscheme gruvbox"))
                              :update_interval 1000}}
                              {1 :glacambre/firenvim
                              :build ":call firenvim#install(0)"}
                              {1 :folke/which-key.nvim
                              :event :VeryLazy
                              :keys [{1 :<leader>?
                                        2 (fn []
                                            ((. (require :which-key) :show) {:global false}))
                                        :desc "Buffer Local Keymaps (which-key)"}]}
                              {1 :nvim-neorg/neorg
                              :dependencies [[:nvim-lua/plenary.nvim]
                                             [:nvim-neorg/neorg-telescope]]
                              :lazy false
                              :opts {:load {:core.concealer {}
                              :core.defaults {}
                              :core.dirman {:config {:default_workspace :journal
                              :workspaces {:journal "~/notes"}}}
                              :core.integrations.telescope {:config {:insert_file_link {:show_title_preview true}}}
                              :core.integrations.treesitter {}
                              :core.journal {:config {:workspace :journal}}
                              :core.qol.todo_items {}
                              :core.ui {}}}
                              :version "*"}
                              {1 :nvim-neotest/neotest
                              :config (fn []
                                        ((. (require :neotest) :setup) {:adapters [((require :neotest-jest) {:cwd (fn [path]
                                                                                                                    (vim.fn.getcwd))
                                                                                                            :jestCommand "npx jest"})]
                                                                       :icons {:failed ""
                                                                       :passed ""
                                                                       :running ""
                                                                       :unknown ""}}))
                              :dependencies [:nvim-neotest/nvim-nio
                                              :nvim-lua/plenary.nvim
                                              :antoinemadec/FixCursorHold.nvim
                                              :nvim-treesitter/nvim-treesitter
                                              :nvim-neotest/neotest-jest]
                              :lazy false}
                              {1 :andythigpen/nvim-coverage
                              :config (fn []
                                        ((. (require :coverage) :setup) {:auto_reload true}))
                              :version "*"}
                              {1 :mfussenegger/nvim-dap
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
                              {1 :nvim-treesitter/nvim-treesitter
                              :build ":TSUpdate"}
                              {1 :vhyrro/luarocks.nvim
                              :config true
                              :priority 1000}
                              {1 :creativenull/efmls-configs-nvim
                              :version :v1.x.x}
                              {1 :nvim-lualine/lualine.nvim
                              :config (fn [])
                              :dependencies [{1 :kyazdani42/nvim-web-devicons
                                                :opt true}]}
                              {1 :stevearc/oil.nvim
                              :dependencies [:nvim-tree/nvim-web-devicons]}
                              {1 :windwp/nvim-autopairs
                              :event :InsertEnter
                              :opts {}}
                              {1 :Olical/conjure
                              :ft [:fennel]
                              :lazy true
                              :dependencies [[ :PaterJason/cmp-conjure]]
                              :init (fn []
                                      (set vim.g.conjure#debug true)
                                      )}
                              {1 :nvim-telescope/telescope.nvim
                              :config (fn []
                                        ((. (require :telescope) :setup) {:extensions {:ui-select [((. (require :telescope.themes)
                                                                                                       :get_dropdown) {})]}})
                                        ((. (require :telescope)
                                            :load_extension) :ui-select))
                              :dependencies [:nvim-lua/plenary.nvim]
                              :tag :0.1.8}
                              ])	
