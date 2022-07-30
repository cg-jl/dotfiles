local wezterm = require 'wezterm'

return {
    -- nice work, wezterm + kitty:
    -- - http://www.leonerd.org.uk/hacks/fixterms/
    -- - https://sw.kovidgoyal.net/kitty/keyboard-protocol/
    enable_csi_u_key_encoding = true,
    enable_kitty_keyboard = true,
    hide_tab_bar_if_only_one_tab = true,
    font = wezterm.font 'JetBrainsMono Nerd Font',
    font_size = 14.0,
    color_scheme = 'ayu',
    window_background_opacity = 0.95,
    quick_select_alphabet = 'aoeuqjkxpyhtnsgcrlmwvzfidb',
    leader = { key = 'mapped:b', mods = 'ALT', timeout_milliseconds = 500 },
    keys = {
        -- panes
        {
            key = 'mapped:_',
            mods = 'LEADER|SHIFT',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
        },
        {
            key = 'mapped:-',
            mods = 'LEADER',
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
        },
        {
            key = 'mapped:x',
            mods = 'LEADER',
            action = wezterm.action.CloseCurrentPane { confirm = true },
        },
        {
            key = 'mapped:b',
            mods = 'LEADER',
            action = wezterm.action.PaneSelect,
        },
        {
            key = 'mapped:H',
            mods = 'LEADER',
            action = wezterm.action.AdjustPaneSize { 'Left', 5 },
        },
        {
            key = 'mapped:L',
            mods = 'LEADER',
            action = wezterm.action.AdjustPaneSize { 'Right', 5 },
        },

        -- tabs (equivalent to tmux windows)
        {
            key = 'mapped:h',
            mods = 'LEADER',
            action = wezterm.action.ActivateTabRelative(-1),
        },
        {
            key = 'mapped:l',
            mods = 'LEADER',
            action = wezterm.action.ActivateTabRelative(1),
        },
        {
            key = 'mapped:w',
            mods = 'LEADER',
            action = wezterm.action.ShowTabNavigator
        },
        {
            key = 'mapped:c',
            mods = 'LEADER',
            action = wezterm.action.SpawnTab 'CurrentPaneDomain'
        },

        -- search
        {
            key = 'mapped:/',
            mods = 'LEADER',
            action = wezterm.action.Search 'CurrentSelectionOrEmptyString',
        },

        -- copy mode!
        {
            key = 'mapped:q',
            mods = 'LEADER',
            action = wezterm.action.ActivateCopyMode
        },

    },
    mouse_bindings = {
        {
            event = { Down = { streak = 3, button =  'Left' } },
            action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
            mods = 'NONE'
        },
    },
}
