(vim.api.nvim_set_option_value :background
                               :dark
                               {})
((. (require :gruvbox)
    :setup) {:contrast :hard})
(vim.cmd "colorscheme gruvbox")
(vim.cmd " hi! TermCursor guifg=NONE guibg=#ebdbb2 gui=NONE cterm=NONE ")
(vim.cmd " hi! TermCursorNC guifg=#ebdbb2 guibg=#3c3836 gui=NONE cterm=NONE ")
((. (require :lualine) :setup) {:options {:theme :gruvbox}
                               :sections {:lualine_c [:filename
                                                       (fn []
                                                         ((. (require :nvim-treesitter)
                                                             :statusline) {:indicator_size 100
                                                          :separator " -> "
                                                          :type_patterns [:class
                                                                           :function
                                                                           :method
                                                                           :pair]}))]
                               :lualine_x [:encoding
                                            {1 :fileformat
                                            :symbols {:unix ""}}
                                            :filetype]}})	
