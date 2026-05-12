local wyn = {
	name = "wyn-lua",

	-- Configuration State
	state = {
		mfact = 0.50, -- wyn split ratio
		orientation = "left", -- left, right, top, bottom, center
		center_threshold = 2, -- amms needed to enable center mode
		fallback_orientation = "left", -- Orientation to use if center condition isn't met
		resize_step = 0.05, -- Step for resizing commands
		windows = {}, -- Persistent data for windows { [win] = { is_wyn = bool, perc_size = float } }
	},
}

local function clamp(val, min, max)
	return math.max(min, math.min(max, val))
end

-- Helper to check if a window in targets is currently focused
-- Note: Robust focus detection in pure lua layout scope can be tricky depending on API version.
-- This implementation supports global layout commands.
local function get_focused_window(ctx)
	-- Iterate targets to see if we can detect the active one
	-- Depending on Hyprland API, ctx might not hold focus directly.
	-- We attempt to find it via properties if available, or fallback to logic.
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

	-- 1. Update persistent state
	-- Remove windows that are gone
	local valid_targets = {}
	for i, win in ipairs(targets) do
		valid_targets[win] = true
		if not wyn.state.windows[win] then
			-- Initialize new window
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

	-- 2. Categorize windows
	local wyns = {}
	local amms = {}
	for _, win in ipairs(targets) do
		if wyn.state.windows[win].is_wyn then
			table.insert(wyns, win)
		else
			table.insert(amms, win)
		end
	end

	local nm = #wyns
	local ns = #amms
	local area = ctx.area

	-- 3. Handle single window case
	if n == 1 then
		targets[1]:place({
			x = area.x,
			y = area.y,
			width = area.width,
			height = area.height,
		})
		return
	end

	-- 4. Determine Orientation
	local orient = wyn.state.orientation

	-- Handle Center orientation fallback
	if orient == "center" then
		if ns < wyn.state.center_threshold then
			orient = wyn.state.fallback_orientation
		end
	end

	-- Helper function to place a list of windows in a rectangle
	-- If vertical is true, splits top/bottom. Else left/right.
	-- Uses 'perc_size' from state to handle smart resizing.
	local function place_windows(wins, rect, vertical)
		local count = #wins
		if count == 0 then
			return
		end

		local current_rect = rect

		-- Calculate total accumulated size to normalize correctly (optional, but good for perfect precision)
		-- Here we do linear split based on float math.
		for i, win in ipairs(wins) do
			local win_data = wyn.state.windows[win]
			local perc = win_data.perc_size or 1.0

			-- Calculate desired size percentage relative to current remaining rect
			-- Logic: Base size is (Total / Count). Actual is Base * perc.
			-- Ratio = (Base * perc) / Total_In_Rect.
			-- However, Total_In_Rect shrinks.
			-- Simplified approach: use ratio of (perc / sum of remaining percs) or just fixed ratios.
			-- C++ logic: uses "accumulated size".
			-- Approximation: multiply perc by (1/count).

			-- If it's the last window, take the rest
			if i == count then
				win:place(current_rect)
			else
				local pool_size = vertical and current_rect.height or current_rect.width
				local avg_size = pool_size / count
				local my_size = avg_size * perc

				local ratio = my_size / pool_size

				-- Clamp ratio to prevent disappearing windows
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

	-- 5. Apply Geometry based on Orientation
	local m_rect = {}
	local s_rects = {}

	-- Calculate wyn Area dimensions
	if orient == "left" then
		local m_w = area.width * wyn.state.mfact
		m_rect = { x = area.x, y = area.y, width = m_w, height = area.height }
		s_rects = { { x = area.x + m_w, y = area.y, width = area.width - m_w, height = area.height } }
	elseif orient == "right" then
		local m_w = area.width * wyn.state.mfact
		m_rect = { x = area.x + area.width - m_w, y = area.y, width = m_w, height = area.height }
		s_rects = { { x = area.x, y = area.y, width = area.width - m_w, height = area.height } }
	elseif orient == "top" then
		local m_h = area.height * wyn.state.mfact
		m_rect = { x = area.x, y = area.y, width = area.width, height = m_h }
		s_rects = { { x = area.x, y = area.y + m_h, width = area.width, height = area.height - m_h } }
	elseif orient == "bottom" then
		local m_h = area.height * wyn.state.mfact
		m_rect = { x = area.x, y = area.y + area.height - m_h, width = area.width, height = m_h }
		s_rects = { { x = area.x, y = area.y, width = area.width, height = area.height - m_h } }
	elseif orient == "center" then
		-- wyn is in the center
		local m_w = area.width * wyn.state.mfact
		local side_w = (area.width - m_w) / 2
		m_rect = { x = area.x + side_w, y = area.y, width = m_w, height = area.height }

		s_rects = {
			{ x = area.x, y = area.y, width = side_w, height = area.height },
			{ x = area.x + side_w + m_w, y = area.y, width = side_w, height = area.height },
		}
	end

	-- Place wyns
	-- If Left/Right/Center: stack vertically (true)
	-- If Top/Bottom: stack horizontally (false)
	local m_vertical = (orient == "left" or orient == "right" or orient == "center")

	place_windows(wyns, m_rect, m_vertical)

	-- Place amms
	-- If Left/Right: stack vertically (true)
	-- If Top/Bottom: stack horizontally (false)
	-- If Center: stack vertically (true) in left and right columns
	local s_vertical = (orient == "left" or orient == "right" or orient == "center")

	if orient ~= "center" then
		place_windows(amms, s_rects[1], s_vertical)
	else
		-- Distribute amms for center layout
		-- Balance between left and right columns
		local s_left = {}
		local s_right = {}
		for i, win in ipairs(amms) do
			if i % 2 == 1 then
				table.insert(s_left, win)
			else
				table.insert(s_right, win)
			end
		end

		place_windows(s_left, s_rects[1], s_vertical)
		place_windows(s_right, s_rects[2], s_vertical)
	end
end

local function handle_layout_msg(ctx, msg)
	local command, args = msg:match("^(%S+)%s*(.*)$")
	local params = {}
	for p in args:gmatch("%S+") do
		table.insert(params, p)
	end

	if
		command == "orientationleft"
		or command == "orientationright"
		or command == "orientationtop"
		or command == "orientationbottom"
		or command == "orientationcenter"
	then
		wyn.state.orientation = command:sub(#"orientation" + 1)
	elseif command == "orientationnext" then
		local os = { "left", "right", "top", "bottom", "center" }
		local current = wyn.state.orientation
		local idx
		for i, v in ipairs(os) do
			if v == current then
				idx = i
				break
			end
		end
		idx = (idx or 1) + 1
		if idx > #os then
			idx = 1
		end
		wyn.state.orientation = os[idx]
	elseif command == "orientationprev" then
		local os = { "left", "right", "top", "bottom", "center" }
		local current = wyn.state.orientation
		local idx
		for i, v in ipairs(os) do
			if v == current then
				idx = i
				break
			end
		end
		idx = (idx or 1) - 1
		if idx < 1 then
			idx = #os
		end
		wyn.state.orientation = os[idx]
	elseif command == "mfact" then
		local val = tonumber(params[1])
		if val then
			wyn.state.mfact = clamp(val, 0.05, 0.95)
		end
	elseif command == "addwyn" then
		-- Find the focused window (if possible) or the first amm
		local focused = get_focused_window(ctx)
		local target = nil

		-- Check if focused is a amm
		if focused and not wyn.state.windows[focused].is_wyn then
			target = focused
		else
			-- Fallback to first amm
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
		-- Similar logic to addwyn, find wyn to demote
		local focused = get_focused_window(ctx)
		local target = nil

		if focused and wyn.state.windows[focused].is_wyn and wyn.state.wyns_count or 0 > 1 then
			target = focused
		else
			-- Fallback to last wyn
			for i = #ctx.targets, 1, -1 do
				local win = ctx.targets[i]
				if wyn.state.windows[win].is_wyn then
					target = win
					break
				end
			end
		end

		if target then
			-- Check if at least 2 wyns to avoid leaving screen bare
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
