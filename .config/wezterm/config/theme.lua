return function(wezterm, config)
  local colors = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

  config.colors = colors
  config.window_frame = {
    active_titlebar_bg = colors.background,
    inactive_titlebar_bg = colors.background,
  }

  return config
end
