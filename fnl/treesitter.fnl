((. (require :nvim-treesitter.configs) :setup) {:auto_install false
                                                :ensure_installed [:vimdoc
                                                                   :javascript
                                                                   :typescript
                                                                   :tsx
                                                                   :lua
                                                                   :java
                                                                   :hcl]
                                                :highlight {:additional_vim_regex_highlighting false
                                                            :enable true}
                                                :sync_install false})    
