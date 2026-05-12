---------------
---- THEME ----
---------------
hl.config({
	general = {
		border_size = 2,
		gaps_in = 2,
		gaps_out = 2,
		col = {
			active_border = "0xff61afef",
			inactive_border = "0xff5c6370",
		},
		layout = "master",
		resize_on_border = true, -- allows dragging border to resize
		locale = "en_AU",
		snap = {
			enabled = true, -- enable snapping for floating windows
		},
	},
	decoration = {
		rounding = 10,
		blur = {
			enabled = false,
		},
		shadow = {
			enabled = false,
		},
		glow = {
			enabled = false,
		},
	},
	master = {
		mfact = 0.7,
		new_status = "master",
		new_on_top = true,
	},
})
