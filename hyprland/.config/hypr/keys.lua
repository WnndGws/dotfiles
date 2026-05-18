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
hl.bind("ALT + TAB", hl.dsp.focus({ workspace = "previous" }))
hl.bind("ALT + q", hl.dsp.window.close())
hl.bind("ALT + code:48", hl.dsp.layout("swapwithmaster"))

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

hl.bind("ALT + l", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + h", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + k", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + j", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + SHIFT + 1", hl.dsp.window.move({ workspace = "1", follow = true }))
hl.bind("ALT + SHIFT + 2", hl.dsp.window.move({ workspace = "2", follow = true }))
hl.bind("ALT + SHIFT + 3", hl.dsp.window.move({ workspace = "3", follow = true }))
hl.bind("ALT + SHIFT + 4", hl.dsp.window.move({ workspace = "4", follow = true }))
hl.bind("ALT + SHIFT + 5", hl.dsp.window.move({ workspace = "5", follow = true }))
hl.bind("ALT + SHIFT + 6", hl.dsp.window.move({ workspace = "6", follow = true }))
hl.bind("ALT + SHIFT + 7", hl.dsp.window.move({ workspace = "7", follow = true }))
hl.bind("ALT + SHIFT + 8", hl.dsp.window.move({ workspace = "8", follow = true }))
hl.bind("ALT + SHIFT + 9", hl.dsp.window.move({ workspace = "9", follow = true }))
hl.bind("ALT + SHIFT + 0", hl.dsp.window.move({ workspace = "10", follow = true }))
