(local default-opts {:remap false})
(local wk (require :which-key))
(wk.add [{1 :gb
          2 (fn []
              ((. (require :dap) :toggle_breakpoint)))
          :desc "toggle breakpoint"}
         {1 "<leader>;" 2 ":" :desc "Run Command"}
         {1 :<leader><leader>
          2 ":Telescope find_files<CR>"
          :desc "Telescope find files"}
         {1 :<leader>b :group :buffer}
         {1 :<leader>bS 2 ":noa w<CR>" :desc "Save (without formatting)"}
         {1 :<leader>bi 2 ":Telescope buffers<CR>" :desc "List buffers"}
         {1 :<leader>bs 2 ":w<CR>" :desc :Save}
         {1 :<leader>c 2 ":copen<CR>" :desc "Open Quickfix"}
         {1 :<leader>d :group :debugger}
         {1 :<leader>dd 2 ":DapContinue<CR>" :desc "Continue Debugging"}
         {1 :<leader>di 2 ":DapStepInto<CR>" :desc "Step Into"}
         {1 :<leader>do 2 ":DapStepOver<CR>" :desc "Step Over"}
         {1 :<leader>g :group :Git}
         {1 :<leader>gd 2 ":Gvdiffsplit<CR>" :desc "Fugitive Diff"}
         {1 :<leader>gD 2 ":Gvdiffsplit!<CR>" :desc "Fugitive Merge"}
         {1 :<leader>gg 2 ":G<CR>" :desc "Open Fugitive"}
         {1 :<leader>hh 2 ":Telescope help_tags<CR>" :desc "Search Helptags"}
         {1 :<leader>p
          2 (fn []
              ((. (require :telescope) :extensions :projects :projects) {}))
          :desc "Switch Project"}
         {1 :<leader>nj
          2 ":Neorg journal today<CR>"
          :desc "Neorg journal for today"}
         {1 :<leader>nm
          2 ":MigrateYesterdayTasks<CR>"
          :desc "Neorg journal migrate tasks"}
         {1 :<leader>ot
          2 (fn []
              (let [term-buf (vim.fn.bufnr "term://*")]
                (if (= term-buf (- 1))
                    (vim.cmd "botright split | resize 20 | terminal")
                    (vim.cmd (.. "botright split | resize 20 | buffer "
                                 term-buf)))))
          :desc "Open Terminal"}
         {1 :<leader>s 2 ":Telescope live_grep<CR>" :desc "Search project"}
         {1 :<leader>t :group :Neotest}
         {1 :<leader>td
          2 (fn []
              ((. (require :neotest) :run :run) {:strategy :dap}))
          :desc "debug test"}
         {1 :<leader>tt
          2 (fn []
              ((. (require :neotest) :run :run) {:jestCommand "npx jest --coverage"}))
          :desc "run test under cursor"}
         {1 :<leader>tf
          2 (fn []
              ((. (require :neotest) :run :run) (vim.fn.expand "%")))
          :desc "test file"}
         {1 :<leader>tt
          2 (fn []
              ((. (require :neotest) :run :run)))
          :desc "run test under cursor"}
         {1 :<leader>tw
          2 "<cmd>lua require('neotest').run.run({ jestCommand = 'npx jest --watch ' })<cr>"
          :desc "run test watch"}
         {1 :<leader>w :group :windows :proxy :<c-w>}
         {1 :<leader>x 2 ":.lua<CR>" :desc "Execute Lua line"}])
(vim.keymap.set :n "-" :<CMD>Oil<CR> {:desc "Open parent directory"})
(vim.keymap.set :i :jk :<Esc>)
(vim.keymap.set :n :Y "\"+y" default-opts)
(vim.keymap.set :t "<C-[>" "<C-\\><C-n>" default-opts)
(vim.keymap.set :t :jk "<C-\\><C-n>" default-opts)
(vim.keymap.set :v :Y "\"+y" default-opts)
(vim.keymap.set :v :<leader>x ":lua<CR>" default-opts)	
