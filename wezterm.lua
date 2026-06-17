local wezterm = require('wezterm')
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window({
    args = cmd,
  })
  window:gui_window():maximize()

  local right        = pane:split { direction = "Right", size = 0.25 }
  local _bottom_left = pane:split { direction = "Bottom", size = 0.4 }
  local _bot_right   = right:split { direction = "Bottom", size = 0.4 }
  pane:activate() -- focus top-left
end)

return {
  color_scheme = "Gruvbox dark, hard (base16)",
  enable_kitty_graphics = true,
  font = wezterm.font("Fira Code"),
  font_size = 16.0,
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    {
      action = act.SplitPane({ direction = "Down", size = { Percent = 30 } }),
      command = { args = { domain = "CurrentPaneDomain" } },
      key = "-",
      mods = "LEADER",
    },
    {
      action = act.SplitPane({ direction = "Right" }),
      command = { args = { domain = "CurrentPaneDomain" } },
      key = "v",
      mods = "LEADER",
    },
    { action = act.AdjustPaneSize({ "Left", 5 }),  key = "H", mods = "LEADER" },
    { action = act.AdjustPaneSize({ "Right", 5 }), key = "L", mods = "LEADER" },
    { action = act.AdjustPaneSize({ "Down", 5 }),  key = "J", mods = "LEADER" },
    { action = act.AdjustPaneSize({ "Up", 5 }),    key = "K", mods = "LEADER" },
    { action = act.SpawnTab("CurrentPaneDomain"),  key = "c", mods = "LEADER" },
    { action = act.ActivatePaneDirection("Left"),  key = "h", mods = "LEADER" },
    { action = act.ActivatePaneDirection("Down"),  key = "j", mods = "LEADER" },
    { action = act.ActivatePaneDirection("Up"),    key = "k", mods = "LEADER" },
    { action = act.ActivatePaneDirection("Right"), key = "l", mods = "LEADER" },
    { action = act.ActivateTabRelative(1),         key = "n", mods = "LEADER" },
    { action = act.ActivateTabRelative(-1),        key = "p", mods = "LEADER" },
    { action = act.ActivateCopyMode,               key = "[", mods = "LEADER" },
    { action = act.TogglePaneZoomState,            key = "z", mods = "LEADER" },
    {
      key = "d",
      mods = "LEADER",
      action = wezterm.action_callback(function(window, pane)
        window:perform_action(act.PromptInputLine {
          description = 'cd all panes to:',
          action = wezterm.action_callback(function(w, p, line)
            if line then
              for _, pan in ipairs(w:active_tab():panes()) do
                pan:send_text('cd "' .. line .. '"\n')
              end
            end
          end),
        }, pane)
      end),
    },
    {
      key = "r",
      mods = "LEADER",
      action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
  },
  leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
  native_macos_fullscreen_mode = false,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  window_decorations = "RESIZE",
  wezterm.on('update-right-status', function(window)
    local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'

    window:set_right_status(wezterm.format {
      { Text = date },
    })
  end)
}
