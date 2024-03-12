local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    local gui_window = window:gui_window();

    gui_window:maximize()

    pane:split { size = 0.6, direction = "Top" }
    pane:split({ direction = "Right" })
end)
return {
    color_scheme = "Gruvbox dark, hard (base16)",
    font = wezterm.font("Fira Code"),
    font_size = 16.0,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    leader = {
        key = "Space",
        mods = "CTRL",
        timeout_milliseconds = 1000,
    },
    keys = {
        {
            key = "-",
            mods = "LEADER",
            action = act.SplitPane({ direction = "Down", size = { Percent = 30 } }),
            command = { args = { domain = "CurrentPaneDomain" } }
        },
        {
            key = "v",
            mods = "LEADER",
            action = act.SplitPane({ direction = "Right" }),
            command = { args = { domain = "CurrentPaneDomain" } }
        },
        { key = 'c', mods = 'LEADER', action = act.SpawnTab("CurrentPaneDomain") },
        { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left') },
        { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down') },
        { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up') },
        { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right') },
        { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
        { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
        { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
    }
}
