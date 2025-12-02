return function(wezterm, config)
  config.font_size = 12
  config.font = wezterm.font("Cascadia Code")
  config.underline_thickness = "2px"

  config.use_fancy_tab_bar = false

  config.tab_bar_at_bottom = true
  config.hide_tab_bar_if_only_one_tab = true

  config.show_close_tab_button_in_tabs = false
  config.show_new_tab_button_in_tab_bar = false

  config.window_close_confirmation = "NeverPrompt"

  return config
end
