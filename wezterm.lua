local wezterm = require 'wezterm'
local act = wezterm.action

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
        { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down') },
        { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up') },
        { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left') },
        { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right') },
    }
}
