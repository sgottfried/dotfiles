(local wezterm (require :wezterm))
(local act wezterm.action)
(local mux wezterm.mux)
(wezterm.on :gui-startup (fn [cmd]
                           (let [(tab pane window) (mux.spawn_window (or cmd {}))
                                 gui-window (window:gui_window)]
                             (gui-window:maximize))))
(fn scheme-for-appearance [appearance]
  (if (appearance:find :Dark) "Gruvbox dark, hard (base16)"
      "Gruvbox light, hard (base16)"))
{:color_scheme (scheme-for-appearance (wezterm.gui.get_appearance))
 :enable_kitty_graphics true
 :font (wezterm.font "Fira Code")
 :font_size 16.0
 :hide_tab_bar_if_only_one_tab true
 :keys [{:action (act.SplitPane {:direction :Down :size {:Percent 30}})
         :command {:args {:domain :CurrentPaneDomain}}
         :key "-"
         :mods :LEADER}
        {:action (act.SplitPane {:direction :Right})
         :command {:args {:domain :CurrentPaneDomain}}
         :key :v
         :mods :LEADER}
        {:action (act.AdjustPaneSize [:Left 5]) :key :H :mods :LEADER}
        {:action (act.AdjustPaneSize [:Right 5]) :key :L :mods :LEADER}
        {:action (act.AdjustPaneSize [:Down 5]) :key :J :mods :LEADER}
        {:action (act.AdjustPaneSize [:Up 5]) :key :K :mods :LEADER}
        {:action (act.PromptInputLine {:action (wezterm.action_callback (fn [window
                                                                             pane
                                                                             line]
                                                                          (when line
                                                                            (: (window:active_tab)
                                                                               :set_title
                                                                               line))))
                                       :description "Enter new name for tab"})
         :key :R
         :mods :LEADER}
        {:action (act.SpawnTab :CurrentPaneDomain) :key :c :mods :LEADER}
        {:action (act.ActivatePaneDirection :Left) :key :h :mods :LEADER}
        {:action (act.ActivatePaneDirection :Down) :key :j :mods :LEADER}
        {:action (act.ActivatePaneDirection :Up) :key :k :mods :LEADER}
        {:action (act.ActivatePaneDirection :Right) :key :l :mods :LEADER}
        {:action (act.ActivateTabRelative 1) :key :n :mods :LEADER}
        {:action (act.ActivateTabRelative (- 1)) :key :p :mods :LEADER}
        {:action act.ActivateCopyMode :key "[" :mods :LEADER}
        {:action act.TogglePaneZoomState :key :z :mods :LEADER}]
 :leader {:key :Space :mods :CTRL :timeout_milliseconds 1000}
 :tab_bar_at_bottom true
 :use_fancy_tab_bar false
 :window_decorations :RESIZE}	
