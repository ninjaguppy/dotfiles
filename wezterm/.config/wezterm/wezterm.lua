-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font {
	family = 'IosevkaSS 14 Nerd Font',
	stretch = 'Expanded',
	weight = 'Regular',
}

config.font_size = 17


-- Color Scheme
config.color_scheme = 'rose-pine-moon'

-- Window information
config.window_decorations = "RESIZE"

-- -- Tab Bar

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.95
config.text_background_opacity = 1
config.window_frame = {
	font_size = 16,
	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = '#333333',

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = '#333333',
}

-- and finally, return the configuration to wezterm
return config
