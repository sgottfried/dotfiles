(vim.api.nvim_create_autocmd [:CursorHold]
                             {:callback (fn [] (vim.diagnostic.open_float))
                             :pattern "*"})
(vim.api.nvim_create_autocmd [:BufWritePre]
                             {:callback (fn [] (vim.lsp.buf.format))})
(vim.api.nvim_create_autocmd :QuickFixCmdPost
                             {:command (vim.cmd :cwindow)
                             :nested true
                             :pattern ["[^l]*"]})
(vim.api.nvim_create_autocmd :Filetype
                             {:callback (fn [] (set vim.opt.bufhidden :delete))
                             :pattern [:gitcommit :gitrebase :gitconfig]})
(vim.api.nvim_create_autocmd :TermOpen
                             {:callback (fn [] (set vim.wo.number false)
                                          (set vim.wo.relativenumber false))
                             :pattern ["*"]})
(fn vim-feedkeys [keys]
  (vim.api.nvim_feedkeys
    (vim.api.nvim_replace_termcodes keys true false true)
    "m" false))

(vim.api.nvim_create_autocmd "BufWinLeave"
  {:pattern ["COMMIT_EDITMSG" "MERGE_MSG" "REBASE_EDITMSG"]
   :callback #(vim-feedkeys "<leader>ot")
   :desc "Run <leader>ot when closing git commit/rebase/merge buffers"})

(vim.api.nvim_create_autocmd 
  "BufWritePost"
  {:pattern "wezterm.fnl"
   :callback (fn []
              (let [output (vim.fn.system 
                            (.. "fennel -c " 
                                (vim.fn.expand "%") 
                                " > " 
                                (vim.fn.expand "%:r") 
                                ".lua"))]
                (when (not= vim.v.shell_error 0)
                  (vim.notify (.. "Error compiling wezterm.fnl:\n" output)
                             vim.log.levels.ERROR))))})
(fn insert-neorg-link []
  (let [link (vim.fn.input "Link: ")
             text (vim.fn.input "Text: ")]
    (vim.api.nvim_set_current_line (.. "{" link "}[" text "]"))))
(fn insert-markdown-link []
  (let [link (vim.fn.input "Link: ")
             text (vim.fn.input "Text: ")]
    (vim.api.nvim_set_current_line (.. "[" text "](" link ")"))))
(vim.api.nvim_create_autocmd :Filetype
                             {:callback (fn []
                                          (set vim.opt_local.conceallevel 2)
                                          (set vim.opt_local.wrap false)
                                          (vim.keymap.set :n :<leader>t
                                                          "<Plug>(neorg.qol.todo-items.todo.task-cycle)"
                                                          {:buffer true})
                                          (vim.keymap.set :i :<C-l>
                                                          insert-neorg-link
                                                          {:buffer true})
                                          (vim.keymap.set :i :<C-d>
                                                          "<Plug>(neorg.tempus.insert-date.insert-mode)"
                                                          {:buffer true}))
                             :pattern :norg})
(vim.api.nvim_create_autocmd :Filetype
                             {:callback (fn []
                                          (vim.keymap.set :i :<C-l>
                                                          insert-markdown-link
                                                          {:buffer true}))
                             :pattern :markdown})
(vim.api.nvim_create_autocmd [:UIEnter]
                             {:callback (fn [event]
                                          (local client
                                                 (. (vim.api.nvim_get_chan_info vim.v.event.chan)
                                                    :client))
                                          (when (and (not= client nil)
                                                     (= client.name :Firenvim))
                                            (set vim.o.laststatus 0)))})	
