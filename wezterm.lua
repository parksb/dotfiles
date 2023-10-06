local wezterm = require "wezterm"
local config = {}

-- font
config.font = wezterm.font_with_fallback {
  { family = 'RobotoMono Nerd Font', weight = 'Medium' },
  { family = 'NanumGothicCoding', weight = 'Bold' },
}
config.font_size = 13

-- padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- appearance and theme
config.color_scheme_dirs = { "~/.config/wezterm" }
config.color_scheme = "Dracula (Official)"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_decorations = "TITLE | RESIZE | MACOS_FORCE_ENABLE_SHADOW"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.8
config.force_reverse_video_cursor = true

-- visual bell
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 50,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 50,
}
config.colors = { visual_bell = "#f8f8f2" }

-- keymap
config.keys = {
  { key = 'n', mods = 'CMD', action = wezterm.action.ActivateTabRelativeNoWrap(1) },
  { key = 'p', mods = 'CMD', action = wezterm.action.ActivateTabRelativeNoWrap(-1) },
  { key = 'l', mods = 'CMD', action = wezterm.action.SplitPane({ direction = "Right" }) },
  { key = 'j', mods = 'CMD', action = wezterm.action.SplitPane({ direction = "Down" }) },
  { key = 'o', mods = 'CMD', action = wezterm.action.ActivatePaneDirection("Next") },
}

return config
