-------------------
---- FUNCTIONS ----
-------------------
local function quarter_toggle()
	local w = hl.get_active_window()
	if w == nil then
		return
	end

	if w.pinned then
		-- currently on: undo
		hl.dispatch(hl.dsp.window.pin()) -- unpin
		if w.floating then
			hl.dispatch(hl.dsp.window.float({ action = "unset" })) -- back to tiling
		end
		return
	end

	-- currently off: apply
	if not w.floating then
		hl.dispatch(hl.dsp.window.float({ action = "set" }))
	end
	hl.dispatch(hl.dsp.window.pin()) -- pin

	local mon = hl.get_active_monitor()
	if mon == nil then
		return
	end
	hl.dispatch(hl.dsp.window.resize({ x = math.floor(mon.width * 0.3), y = math.floor(mon.height * 0.3) }))
	hl.dispatch(hl.dsp.window.move({ x = math.floor(mon.width * 0.3), y = math.floor(mon.height * 0.3) + 40 })) -- 40 is waybar
end

local function non_monitor()
	local cur = hl.get_active_monitor()
	local last = hl.get_last_workspace()

	-- previous workspace is on another monitor: jump to it
	if last and last.monitor and last.monitor.name ~= cur.name then
		hl.dispatch(hl.dsp.focus({ workspace = last.id }))
		return
	end

	-- previous workspace is on this monitor: go to the other monitor,
	-- which restores its active workspace
	for _, mon in ipairs(hl.get_monitors()) do
		if mon.name ~= cur.name then
			hl.dispatch(hl.dsp.focus({ monitor = mon.name }))
			return
		end
	end
end

------------------
---- KEYBOARD ----
------------------
hl.device({ name = "synaptics-tm3145-005", enabled = false })
hl.config({
	input = {
		kb_layout = "us",
		kb_options = "caps:escape",
		follow_mouse = 2, -- Need to click to change focus
		follow_mouse_shrink = 10, -- 10px deadzone for follow mouse
	},
	binds = {
		allow_workspace_cycles = true,
		focus_preferred_method = 1, -- longest edge
	},
	cursor = {
		hide_on_key_press = true,
		inactive_timeout = 2,
	},
})

------------------
---- KEYBINDS ----
------------------
--- SHORTCUTS
hl.bind("ALT + Space", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

--- PROGRAMS
hl.bind("ALT + Return", hl.dsp.exec_cmd("$HOME/git/scripts/hypr_open_shell_in_pwd.sh"))
hl.bind("ALT + c", hl.dsp.exec_cmd("mullvad-exclude chromium --enable-features=FakeLocation", { workspace = 4 }))
hl.bind("ALT + f", hl.dsp.exec_cmd("firefox", { workspace = 6 }))
hl.bind("ALT + F9", hl.dsp.exec_cmd("~/git/scripts/keyboard_backlight_toggle.sh"))
hl.bind("ALT + F10", hl.dsp.exec_cmd("~/git/scripts/headphone_toggler.sh"))
hl.bind("ALT + i", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind(
	"PRINT",
	hl.dsp.exec_cmd(
		'grim -g "$(slurp)" slurp.png && kdeconnect-cli --share=slurp.png --device=5289ba3e7a93456babf9d8ae89cc9da6 && sleep 1 && rm slurp.png'
	)
)

--- VOLUME
hl.bind("ALT + XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("ALT + F1", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("ALT + F2", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("ALT + F3", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("ALT + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("ALT + F5", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("ALT + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"))
hl.bind("ALT + F6", hl.dsp.exec_cmd("brightnessctl set 5%+"))

--- MOVEMENT
hl.bind("ALT + period", quarter_toggle)

hl.bind("ALT + SHIFT + h", hl.dsp.layout("cycleprev noloop"))
hl.bind("ALT + SHIFT + l", hl.dsp.layout("cyclenext noloop"))
hl.bind("ALT + SHIFT + j", hl.dsp.layout("swapprev noloop"))
hl.bind("ALT + SHIFT + k", hl.dsp.layout("swapnext noloop"))
hl.bind("ALT + SHIFT + m", hl.dsp.layout("swapwithmaster"))

hl.bind("ALT + grave", hl.dsp.window.cycle_next())
hl.bind("ALT + TAB", hl.dsp.focus({ workspace = "previous_per_monitor" }))
hl.bind("ALT + ESCAPE", non_monitor)
hl.bind("ALT + q", hl.dsp.window.close())
hl.bind("ALT + code:48", hl.dsp.layout("swapwithmaster"))
hl.bind("ALT + LEFT", hl.dsp.focus({ workspace = "m-1" }))
hl.bind("ALT + RIGHT", hl.dsp.focus({ workspace = "m+1" }))

hl.bind("ALT + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("ALT + a", hl.dsp.focus({ workspace = "1" }))
hl.bind("ALT + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("ALT + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("ALT + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("ALT + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("ALT + s", hl.dsp.focus({ workspace = "5" }))
hl.bind("ALT + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("ALT + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("ALT + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("ALT + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind("ALT + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind("ALT + d", hl.dsp.focus({ workspace = "10" }))

hl.bind("ALT + l", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + h", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + k", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + j", hl.dsp.focus({ direction = "down" }))

hl.bind("SHIFT + ALT + 1", hl.dsp.window.move({ workspace = "1", follow = true }))
hl.bind("SHIFT + ALT + 2", hl.dsp.window.move({ workspace = "2", follow = true }))
hl.bind("SHIFT + ALT + 3", hl.dsp.window.move({ workspace = "3", follow = true }))
hl.bind("SHIFT + ALT + 4", hl.dsp.window.move({ workspace = "4", follow = true }))
hl.bind("SHIFT + ALT + 5", hl.dsp.window.move({ workspace = "5", follow = true }))
hl.bind("SHIFT + ALT + 6", hl.dsp.window.move({ workspace = "6", follow = true }))
hl.bind("SHIFT + ALT + 7", hl.dsp.window.move({ workspace = "7", follow = true }))
hl.bind("SHIFT + ALT + 8", hl.dsp.window.move({ workspace = "8", follow = true }))
hl.bind("SHIFT + ALT + 9", hl.dsp.window.move({ workspace = "9", follow = true }))
hl.bind("SHIFT + ALT + 0", hl.dsp.window.move({ workspace = "10", follow = true }))
