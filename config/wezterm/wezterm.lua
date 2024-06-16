local wezterm = require("wezterm")

local function font_with_fallback(name, params)
	local names = { name, "FiraCode Nerd Font" }
	return wezterm.font_with_fallback(names, params)
end

-- local function readjust_font_size(window, pane)
-- 	local window_dims = window:get_dimensions()
-- 	local pane_dims = pane:get_dimensions()

-- 	local config_overrides = {}
-- 	local initial_font_size = 14 -- Set to your desired font size
-- 	config_overrides.font_size = initial_font_size

-- 	local max_iterations = 5
-- 	local iteration_count = 0
-- 	local tolerance = 3

-- 	-- Calculate the initial difference between window and pane heights
-- 	local current_diff = window_dims.pixel_height - pane_dims.pixel_height
-- 	local min_diff = math.abs(current_diff)
-- 	local best_font_size = initial_font_size

-- 	-- Loop to adjust font size until the difference is within tolerance or max iterations reached
-- 	while current_diff > tolerance and iteration_count < max_iterations do
-- 		-- Increment the font size slightly
-- 		config_overrides.font_size = config_overrides.font_size + 0.5
-- 		window:set_config_overrides(config_overrides)

-- 		-- Update dimensions after changing font size
-- 		window_dims = window:get_dimensions()
-- 		pane_dims = pane:get_dimensions()
-- 		current_diff = window_dims.pixel_height - pane_dims.pixel_height

-- 		-- Check if the current difference is the smallest seen so far
-- 		local abs_diff = math.abs(current_diff)
-- 		if abs_diff < min_diff then
-- 			min_diff = abs_diff
-- 			best_font_size = config_overrides.font_size
-- 		end

-- 		iteration_count = iteration_count + 1
-- 	end

-- 	-- If no acceptable difference was found, set the font size to the best one encountered
-- 	if current_diff > tolerance then
-- 		config_overrides.font_size = best_font_size
-- 		window:set_config_overrides(config_overrides)
-- 	end
-- end

-- wezterm.on("window-resized", function(window, pane)
-- 	readjust_font_size(window, pane)
-- end)

return {
	font_size = 14,
	bold_brightens_ansi_colors = false,
	font = wezterm.font("FiraCode Nerd Font", { weight = 'Regular', italic = false }),
	window_padding = {
		-- left = 30,
		-- right = 10,
		-- top = 30,
		-- bottom = -30,
	},

	window_decorations = "RESIZE",
	native_macos_fullscreen_mode = false,
	hide_mouse_cursor_when_typing = true,
	pane_focus_follows_mouse = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	enable_tab_bar = true,
	tab_max_width = 32,

	-- window_frame = {
	-- 	border_left_width = '0.5cell',
	-- 	border_right_width = '0.5cell',
	-- 	border_bottom_height = '0.25cell',
	-- 	border_top_height = '0.25cell',
	-- 	border_left_color = 'purple',
	-- 	border_right_color = 'purple',
	-- 	border_bottom_color = 'purple',
	-- 	border_top_color = 'purple',
	-- },

	color_scheme = "tokyonight_moon",
	colors = {
		-- split = "#444444",
		tab_bar = {

		}
	},


}
