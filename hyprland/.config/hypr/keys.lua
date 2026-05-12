------------------
---- KEYBOARD ----
------------------
hl.config({
	input = {
		kb_layout = "us",
		kb_options = "caps:escape",
		follow_mouse = 1,
		follow_mouse_shrink = 10, -- 10px deadzone for follow mouse
		touchpad = {
			disable_while_typing = true,
			natural_scroll = false,
			tap_to_click = false,
		},
	},
	binds = {
		allow_workspace_cycles = true,
		focus_preferred_method = 1, -- longest edge
	},
	cursor = {
		hide_on_key_press = true,
	},
})

------------------
---- KEYBINDS ----
------------------
--- PROGRAMS
hl.bind("ALT + Return", hl.dsp.exec_cmd("alacritty"))
hl.bind("ALT + f", hl.dsp.exec_cmd("firefox", { workspace = 10 }))

--- MOVEMENT
hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "previous" }))
hl.bind("ALT + q", hl.dsp.window.close())
hl.bind("ALT + code:48", hl.dsp.layout("swapwithmaster"))
hl.bind("ALT + l", hl.dsp.layout("cyclenext"))

hl.bind("ALT + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("ALT + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("ALT + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("ALT + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("ALT + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("ALT + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("ALT + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("ALT + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("ALT + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind("ALT + 0", hl.dsp.focus({ workspace = "10" }))
