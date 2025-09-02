(local default-opts {:remap false})
(local wk (require :which-key))

(macro add-group [keybinding group-name]
         `(wk.add [{1 ,keybinding :group ,group-name}]))

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

(add-group :<leader>b :buffer)
(add-group :<leader>d :debugger)
(add-group :<leader>g :Git)
(add-group :<leader>t :Neotest)
(add-insert-mode-keybinding :jk :<Esc>)
(add-keybinding "-" ":Oil<CR>" "Open parent directory")
(add-keybinding "<leader>;" ":" :desc "Run Command")
(add-keybinding :<leader><leader> ":Telescope find_files<CR>" "Telescope find files")
(add-keybinding :<leader>bS ":noa w<CR>" "Save (without formatting)")
(add-keybinding :<leader>bi ":Telescope buffers<CR>" "List buffers")
(add-keybinding :<leader>bs ":w<CR>" "Save")
(add-keybinding :<leader>c ":copen<CR>" "Open Quickfix")
(add-keybinding :<leader>dd ":DapContinue<CR>" "Continue Debugging")
(add-keybinding :<leader>di ":DapStepInto<CR>" "Step Into")
(add-keybinding :<leader>do ":DapStepOver<CR>" "Step Over")
(add-keybinding :<leader>gD ":Gvdiffsplit!<CR>" "Fugitive Merge")
(add-keybinding :<leader>gd ":Gvdiffsplit<CR>" "Fugitive Diff")
(add-keybinding :<leader>gg ":G<CR>" "Open Fugitive")
(add-keybinding :<leader>hh ":Telescope help_tags<CR>" "Search Helptags")
(add-keybinding :<leader>nj ":Neorg journal today<CR>" "Neorg journal for today")
(add-keybinding :<leader>nm ":MigrateYesterdayTasks<CR>" "Neorg journal migrate tasks")
(add-keybinding :<leader>ot (fn []
                             (let [term-buf (vim.fn.bufnr "term://*")]
                               (if (= term-buf (- 1))
                                   (vim.cmd "botright split | resize 20 | terminal")
                                   (vim.cmd (.. "botright split | resize 20 | buffer "
                                                term-buf))))) "Open Terminal")
(add-keybinding :<leader>s ":Telescope live_grep<CR>" "Search project")
(add-keybinding :<leader>td (fn []
                             ((. (require :neotest) :run :run) {:strategy :dap})) "debug test")
(add-keybinding :<leader>tt (fn []
                             ((. (require :neotest) :run :run) {:jestCommand "npx jest --coverage"})) "run test under cursor")
(add-keybinding :<leader>tf (fn []
                             ((. (require :neotest) :run :run) (vim.fn.expand "%"))) "test file")
(add-keybinding :<leader>tw "<cmd>lua require('neotest').run.run({ jestCommand = 'npx jest --watch ' })<cr>" "run test watch")
(add-keybinding :<leader>x ":.lua<CR>" "Execute Lua line")
(add-keybinding :gb ":DapToggleBreakpoint<CR>" "toggle breakpoint")
(add-keybinding :Y "\"+y" "Yank to system clipboard")
(add-proxy-group :<leader>w :windows :<c-w>)
(add-terminal-mode-keybinding "<C-[" "<C-\\><C-n>")
(add-terminal-mode-keybinding :jk "<C-\\><C-n>")
(add-visual-mode-keybinding :<leader>x ":lua<CR>")
(add-visual-mode-keybinding :Y "\"+y")
