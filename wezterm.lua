local wezterm = require "wezterm"
local config = {}

-- font
config.font = wezterm.font("RobotoMono Nerd Font", { weight = "Medium" })
config.font_size = 13

-- padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- theme
config.color_scheme_dirs = { "~/.config/wezterm" }
config.color_scheme = "Dracula (Official)"
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.colors = { visual_bell = "#f8f8f2" }

-- visual bell
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 50,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 50,
}

-- keymap
config.keys = {
  {
    key = 'l',
    mods = 'CMD',
    action = wezterm.action.SplitPane({ direction = "Right" }),
  },
  {
    key = 'm',
    mods = 'CMD',
    action = wezterm.action.SplitPane({ direction = "Down" }),
  },
  {
    key = 'o',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection "Next",
  },
}

return config
