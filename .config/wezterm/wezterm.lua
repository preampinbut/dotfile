local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 12
config.font = wezterm.font("Cascadia Code")
config.underline_thickness = "2px"

config.use_fancy_tab_bar = false

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false

local colors = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

config.colors = colors
config.window_frame = {
  active_titlebar_bg = colors.background,
  inactive_titlebar_bg = colors.background,
}

config.keys = {
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
}

return config
