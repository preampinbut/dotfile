local wezterm = require("wezterm")
local config = wezterm.config_builder()

config = require("config.settings")(wezterm, config)
config = require("config.theme")(wezterm, config)
config = require("config.keys")(wezterm, config)
config = require("config.scrollback")(wezterm, config)

return config
