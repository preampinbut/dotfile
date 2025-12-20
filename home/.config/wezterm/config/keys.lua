return function(wezterm, config)
	config.keys = {
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action.CloseCurrentTab({ confirm = false }),
		},
		{
			key = "Enter",
			mods = "SHIFT",
			action = wezterm.action({ SendString = "\x1b\r" }),
		},
	}

	return config
end
