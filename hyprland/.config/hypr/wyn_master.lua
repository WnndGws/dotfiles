local wyn = {
	name = "wyn-lua",

	state = {
		mfact = 0.50, -- Main split ratio
		windows = {}, -- Persistent data for windows { [win] = { is_wyn = bool, perc_size = float } }
	},
}

local function clamp(val, min, max)
	return math.max(min, math.min(max, val))
end

local function get_focused_window(ctx)
	for _, win in ipairs(ctx.targets) do
		if win.focused then
			return win
		end
	end
	return nil
end

local function recalculate_wyn(ctx)
	local targets = ctx.targets
	local n = #targets
	if n == 0 then
		return
	end

	-- Update persistent state
	local valid_targets = {}
	for i, win in ipairs(targets) do
		valid_targets[win] = true
		if not wyn.state.windows[win] then
			wyn.state.windows[win] = {
				is_wyn = false,
				perc_size = 1.0,
			}
		end
	end

	-- Cleanup missing windows
	for win, data in pairs(wyn.state.windows) do
		if not valid_targets[win] then
			wyn.state.windows[win] = nil
		end
	end

	-- Ensure we have at least one wyn if we have windows
	local has_wyn = false
	for _, data in pairs(wyn.state.windows) do
		if data.is_wyn then
			has_wyn = true
			break
		end
	end

	if not has_wyn and n > 0 then
		wyn.state.windows[targets[1]].is_wyn = true
	end

	-- Categorize windows
	local wyns = {}
	local amms = {}
	for _, win in ipairs(targets) do
		if wyn.state.windows[win].is_wyn then
			table.insert(wyns, win)
		else
			table.insert(amms, win)
		end
	end

	local area = ctx.area

	-- Handle single window case
	if n == 1 then
		targets[1]:place({
			x = area.x,
			y = area.y,
			width = area.width,
			height = area.height,
		})
		return
	end

	-- Helper to place a list of windows in a rectangle
	local function place_windows(wins, rect, vertical)
		local count = #wins
		if count == 0 then
			return
		end

		local current_rect = rect

		for i, win in ipairs(wins) do
			local win_data = wyn.state.windows[win]
			local perc = win_data.perc_size or 1.0

			if i == count then
				win:place(current_rect)
			else
				local pool_size = vertical and current_rect.height or current_rect.width
				local avg_size = pool_size / count
				local my_size = avg_size * perc
				local ratio = my_size / pool_size

				ratio = clamp(ratio, 0.05, 0.95)

				local sub_rect
				local remainder_rect

				if vertical then
					sub_rect = ctx:split(current_rect, "top", ratio)
					remainder_rect = ctx:split(current_rect, "bottom", 1.0 - ratio)
				else
					sub_rect = ctx:split(current_rect, "left", ratio)
					remainder_rect = ctx:split(current_rect, "right", 1.0 - ratio)
				end

				win:place(sub_rect)
				current_rect = remainder_rect
			end
		end
	end

	-- Apply Fixed Left Orientation
	local m_rect
	local s_rects

	-- Left: Wyns take mfact on the left
	local m_w = area.width * wyn.state.mfact
	m_rect = { x = area.x, y = area.y, width = m_w, height = area.height }
	s_rects = { { x = area.x + m_w, y = area.y, width = area.width - m_w, height = area.height } }

	-- Stack Wyns vertically
	place_windows(wyns, m_rect, true)

	-- Stack Amms vertically
	place_windows(amms, s_rects[1], true)
end

local function handle_layout_msg(ctx, msg)
	local command, args = msg:match("^(%S+)%s*(.*)$")
	local params = {}
	for p in args:gmatch("%S+") do
		table.insert(params, p)
	end

	if command == "mfact" then
		local val = tonumber(params[1])
		if val then
			wyn.state.mfact = clamp(val, 0.05, 0.95)
		end
	elseif command == "addwyn" then
		local focused = get_focused_window(ctx)
		local target = nil

		if focused and not wyn.state.windows[focused].is_wyn then
			target = focused
		else
			for _, win in ipairs(ctx.targets) do
				if not wyn.state.windows[win].is_wyn then
					target = win
					break
				end
			end
		end

		if target then
			wyn.state.windows[target].is_wyn = true
		end
	elseif command == "removewyn" then
		local focused = get_focused_window(ctx)
		local target = nil

		if focused and wyn.state.windows[focused].is_wyn then
			target = focused
		else
			for i = #ctx.targets, 1, -1 do
				local win = ctx.targets[i]
				if wyn.state.windows[win].is_wyn then
					target = win
					break
				end
			end
		end

		if target then
			local m_count = 0
			for _, win in ipairs(ctx.targets) do
				if wyn.state.windows[win].is_wyn then
					m_count = m_count + 1
				end
			end

			if m_count > 1 then
				wyn.state.windows[target].is_wyn = false
			end
		end
	else
		return "unknown command: " .. command
	end

	return true
end

-- Register the layout
hl.layout.register(wyn.name, {
	recalculate = recalculate_wyn,
	layout_msg = handle_layout_msg,
})
