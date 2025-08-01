(local cmp (require :cmp))
(when (not= cmp nil)
  (cmp.setup {:mapping {:<C-Space> (cmp.mapping.complete)
             :<C-d> (cmp.mapping.scroll_docs (- 4))
             :<C-e> (cmp.mapping.close)
             :<C-f> (cmp.mapping.scroll_docs 4)
             :<C-n> (cmp.mapping.select_next_item)
             :<C-p> (cmp.mapping.select_prev_item)
             :<C-y> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                         :select true})}
             :snippet {:expand (fn [])}
             :sources (cmp.config.sources [{:name :nvim_lsp} {:name :buffer}])})
  (vim.cmd "                                                                                                                                                                                                                    set completeopt=menuone,noinsert,noselect
           highlight! default link CmpItemKind CmpItemMenuDefault
           "))	
