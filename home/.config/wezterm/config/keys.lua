return function(wezterm, config)
  config.keys = {
    {
      key = "w",
      mods = "CMD",
      action = wezterm.action.CloseCurrentTab({ confirm = false }),
    },
  }

  return config
end
