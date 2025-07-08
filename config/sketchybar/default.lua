local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
	update_freq = 1,
	icon = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = 16.0,
		},
		color = colors.yellow,
		highlight = colors.background,
		padding_left = 6,
		padding_right = 2,
		corner_radius = 1,
		background = { image = { corner_radius = 1 } },
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Semibold"],
			size = 13.0,
		},
		color = colors.yellow,
		highlight = colors.background,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	background = {
		height = 27,
		corner_radius = 0,
		border_width = 1,
		border_color = colors.yellow,
		image = {
			corner_radius = 0,
		},
	},
	popup = {
		background = {
			border_width = 1,
			corner_radius = 0,
			border_color = colors.popup.border,
			color = colors.popup.bg,
			shadow = { drawing = true },
		},
		blur_radius = 50,
	},
	padding_left = 4,
	padding_right = 4,
	scroll_texts = true,
})
