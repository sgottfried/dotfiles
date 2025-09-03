(local default-opts {:remap false})
(local wk (require :which-key))

(macro add-group [prefix group-name mappings]
  (do
    `(wk.add [{1 ,prefix :group ,group-name}])
    `(wk.add (icollect [_# [keybinding# command# desc#] (ipairs ,mappings)]
               {1 (.. ,prefix keybinding#) 2 command# :desc desc#}))))

(macro add-insert-mode-keybinding [keybinding command]
  `(vim.keymap.set :i ,keybinding ,command))

(macro add-keybinding [keybinding command desc]
  `(wk.add [{1 ,keybinding 2 ,command :desc ,desc}]))

(macro add-proxy-group [keybinding group-name proxy-keybinding]
  `(wk.add [{1 ,keybinding :group ,group-name :proxy ,proxy-keybinding}]))

(macro add-terminal-mode-keybinding [keybinding command]
  `(vim.keymap.set :t ,keybinding ,command default-opts))

(macro add-visual-mode-keybinding [keybinding command]
  `(vim.keymap.set :v ,keybinding ,command default-opts))

(add-group :<leader>b :buffer [
                               [:S ":noa w<CR>" "Save (without formatting)"]
                               [:i ":Telescope buffers<CR>" "List buffers"]
                               [:s ":w<CR>" "Save"]
                               ])
(add-group :<leader>d :debugger [
                                 [:d ":DapContinue<CR>" "Continue Debugging"]
                                 [:i ":DapStepInto<CR>" "Step Into"]
                                 [:o ":DapStepOver<CR>" "Step Over"]
                                 ])
(add-group :<leader>g :Git [
                            [:D ":Gvdiffsplit!<CR>" "Git Merge"]
                            [:d ":Gvdiffsplit<CR>" "Git Diff"]
                            [:g ":G<CR>" "Open Fugitive"]
                            ])
(add-group :<leader>n :neorg [
                              [:m ":MigrateYesterdayTasks<CR>" "Neorg journal migrate tasks" ]
                             [:j ":Neorg journal today<CR>" "Neorg journal for today"]
                             ])
(add-group :<leader>t :Neotest [
                                [:d (fn []
                                      ((. (require :neotest) :run :run) {:strategy :dap})) "Debug Test"]
                                [:f (fn []
                                      ((. (require :neotest) :run :run) (vim.fn.expand "%"))) "Test File"]
                                [:t (fn []
                                      ((. (require :neotest) :run :run) {:jestCommand "npx jest --coverage"})) "Run Test Under Cursor"]
                                [:w "<cmd>lua require('neotest').run.run({ jestCommand = 'npx jest --watch ' })<cr>" "Run Test in Watch Mode"]
                                ])
(add-insert-mode-keybinding :jk :<Esc>)
(add-keybinding "-" ":Oil<CR>" "Open parent directory")
(add-keybinding "<leader>;" ":" :desc "Run Command")
(add-keybinding :<leader><leader> ":Telescope find_files<CR>" "Telescope find files")
(add-keybinding :<leader>c ":copen<CR>" "Open Quickfix")
(add-keybinding :<leader>hh ":Telescope help_tags<CR>" "Search Helptags")
(add-keybinding :<leader>ot (fn []
                              (let [term-buf (vim.fn.bufnr "term://*")]
                                (if (= term-buf (- 1))
                                    (vim.cmd "botright split | resize 20 | terminal")
                                    (vim.cmd (.. "botright split | resize 20 | buffer "
                                                 term-buf))))) "Open Terminal")
(add-keybinding :<leader>s ":Telescope live_grep<CR>" "Search project")
(add-keybinding :<leader>x ":.lua<CR>" "Execute Lua line")
(add-keybinding :gb ":DapToggleBreakpoint<CR>" "toggle breakpoint")
(add-keybinding :Y "\"+y" "Yank to system clipboard")
(add-proxy-group :<leader>w :windows :<c-w>)
(add-terminal-mode-keybinding "<C-[>" "<C-\\><C-n>")
(add-terminal-mode-keybinding :jk "<C-\\><C-n>")
(add-visual-mode-keybinding :<leader>x ":lua<CR>")
(add-visual-mode-keybinding :Y "\"+y")
