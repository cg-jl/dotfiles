local wezterm = require 'wezterm'

return {
    -- nice work, wezterm + kitty:
    -- - http://www.leonerd.org.uk/hacks/fixterms/
    -- - https://sw.kovidgoyal.net/kitty/keyboard-protocol/
    hide_tab_bar_if_only_one_tab = true,
    font = wezterm.font 'MesloLGS Nerd Font Mono',
    font_size = 15.0,
    color_scheme = 'ayu',
    check_for_updates = false,
    show_update_window = false,
    window_background_opacity = 0.95,
    quick_select_alphabet = 'aoeuqjkxpyhtnsgcrlmwvzfidb',
    leader = { key = 'mapped:b', mods = 'ALT', timeout_milliseconds = 300 },
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
        {
            key = 'mapped:h',
            mods = 'LEADER',
            action = wezterm.action.ActivatePaneDirection 'Left',
        },
        {
            key = 'mapped:l',
            mods = 'LEADER',
            action = wezterm.action.ActivatePaneDirection 'Right',
        },
        {
            key = 'mapped:j',
            mods = 'LEADER',
            action = wezterm.action.ActivatePaneDirection 'Down',
        },
        {
            key = 'mapped:k',
            mods = 'LEADER',
            action = wezterm.action.ActivatePaneDirection 'Up',
        },

        -- tabs (equivalent to tmux windows)
        {
            key = 'mapped:h',
            mods = 'LEADER|CTRL',
            action = wezterm.action.ActivateTabRelative(-1),
        },
        {
            key = 'mapped:l',
            mods = 'LEADER|CTRL',
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

        -- disable ctrl+shift+n
        { 
            key = 'mapped:n',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.Nop
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
