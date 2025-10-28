local wezterm = require('wezterm')
local act = wezterm.action
local mux = wezterm.mux

local function scheme_for_appearance(appearance)
  if string.find(appearance, 'Dark') then
    return "Gruvbox dark, hard (base16)"
  else
    return "Gruvbox light, hard (base16)"
  end
end

wezterm.on('gui-startup', function(cmd)
  local success, initial_dir = wezterm.run_child_process({
    'osascript',
    '-e',
    'set the_dir to text returned of (display dialog "Enter directory path:" default answer "' ..
        os.getenv("HOME") .. '")'
  })

  -- Use home directory if dialog was cancelled or empty
  initial_dir = (success and initial_dir ~= '') and initial_dir:gsub("^%s*(.-)%s*$", "%1") or os.getenv("HOME")
  local tab, pane, window = mux.spawn_window({
    cwd = initial_dir,
    args = cmd,
  })
  pane:split { size = 0.6, direction = "Top", cwd = initial_dir }
  pane:split { size = 0.5, direction = "Right", cwd = initial_dir }
end)

wezterm.on('mux-window-created', function(window, pane)
  -- This ensures the command runs when a new tab/window is created
  window:perform_action(
    wezterm.action.Multiple {
      wezterm.action.SendString 'gui-startup\n',
    },
    pane
  )
end)

return {
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
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
    { action = act.AdjustPaneSize({ "Left", 5 }), key = "H", mods = "LEADER" },
    { action = act.AdjustPaneSize({ "Right", 5 }), key = "L", mods = "LEADER" },
    { action = act.AdjustPaneSize({ "Down", 5 }), key = "J", mods = "LEADER" },
    { action = act.AdjustPaneSize({ "Up", 5 }), key = "K", mods = "LEADER" },
    { action = act.SpawnTab("CurrentPaneDomain"), key = "c", mods = "LEADER" },
    { action = act.ActivatePaneDirection("Left"), key = "h", mods = "LEADER" },
    { action = act.ActivatePaneDirection("Down"), key = "j", mods = "LEADER" },
    { action = act.ActivatePaneDirection("Up"), key = "k", mods = "LEADER" },
    { action = act.ActivatePaneDirection("Right"), key = "l", mods = "LEADER" },
    { action = act.ActivateTabRelative(1), key = "n", mods = "LEADER" },
    { action = act.ActivateTabRelative(-1), key = "p", mods = "LEADER" },
    { action = act.ActivateCopyMode, key = "[", mods = "LEADER" },
    { action = act.TogglePaneZoomState, key = "z", mods = "LEADER" },
  },
  leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  window_decorations = "RESIZE",
}
