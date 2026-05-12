local master = {
	name = "master-lua",

	-- Configuration State
	state = {
		mfact = 0.55, -- Master split ratio
		orientation = "left", -- left, right, top, bottom, center
		center_threshold = 2, -- Slaves needed to enable center mode
		fallback_orientation = "left", -- Orientation to use if center condition isn't met
		resize_step = 0.05, -- Step for resizing commands
		windows = {}, -- Persistent data for windows { [win] = { is_master = bool, perc_size = float } }
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

local function recalculate_master(ctx)
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
		if not master.state.windows[win] then
			-- Initialize new window
			master.state.windows[win] = {
				is_master = false,
				perc_size = 1.0,
			}
		end
	end

	-- Cleanup missing windows
	for win, data in pairs(master.state.windows) do
		if not valid_targets[win] then
			master.state.windows[win] = nil
		end
	end

	-- Ensure we have at least one master if we have windows
	local has_master = false
	for _, data in pairs(master.state.windows) do
		if data.is_master then
			has_master = true
			break
		end
	end

	if not has_master and n > 0 then
		master.state.windows[targets[1]].is_master = true
	end

	-- 2. Categorize windows
	local masters = {}
	local slaves = {}
	for _, win in ipairs(targets) do
		if master.state.windows[win].is_master then
			table.insert(masters, win)
		else
			table.insert(slaves, win)
		end
	end

	local nm = #masters
	local ns = #slaves
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
	local orient = master.state.orientation

	-- Handle Center orientation fallback
	if orient == "center" then
		if ns < master.state.center_threshold then
			orient = master.state.fallback_orientation
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
			local win_data = master.state.windows[win]
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

	-- Calculate Master Area dimensions
	if orient == "left" then
		local m_w = area.width * master.state.mfact
		m_rect = { x = area.x, y = area.y, width = m_w, height = area.height }
		s_rects = { { x = area.x + m_w, y = area.y, width = area.width - m_w, height = area.height } }
	elseif orient == "right" then
		local m_w = area.width * master.state.mfact
		m_rect = { x = area.x + area.width - m_w, y = area.y, width = m_w, height = area.height }
		s_rects = { { x = area.x, y = area.y, width = area.width - m_w, height = area.height } }
	elseif orient == "top" then
		local m_h = area.height * master.state.mfact
		m_rect = { x = area.x, y = area.y, width = area.width, height = m_h }
		s_rects = { { x = area.x, y = area.y + m_h, width = area.width, height = area.height - m_h } }
	elseif orient == "bottom" then
		local m_h = area.height * master.state.mfact
		m_rect = { x = area.x, y = area.y + area.height - m_h, width = area.width, height = m_h }
		s_rects = { { x = area.x, y = area.y, width = area.width, height = area.height - m_h } }
	elseif orient == "center" then
		-- Master is in the center
		local m_w = area.width * master.state.mfact
		local side_w = (area.width - m_w) / 2
		m_rect = { x = area.x + side_w, y = area.y, width = m_w, height = area.height }

		s_rects = {
			{ x = area.x, y = area.y, width = side_w, height = area.height },
			{ x = area.x + side_w + m_w, y = area.y, width = side_w, height = area.height },
		}
	end

	-- Place Masters
	-- If Left/Right/Center: stack vertically (true)
	-- If Top/Bottom: stack horizontally (false)
	local m_vertical = (orient == "left" or orient == "right" or orient == "center")

	place_windows(masters, m_rect, m_vertical)

	-- Place Slaves
	-- If Left/Right: stack vertically (true)
	-- If Top/Bottom: stack horizontally (false)
	-- If Center: stack vertically (true) in left and right columns
	local s_vertical = (orient == "left" or orient == "right" or orient == "center")

	if orient ~= "center" then
		place_windows(slaves, s_rects[1], s_vertical)
	else
		-- Distribute slaves for center layout
		-- Balance between left and right columns
		local s_left = {}
		local s_right = {}
		for i, win in ipairs(slaves) do
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
		master.state.orientation = command:sub(#"orientation" + 1)
	elseif command == "orientationnext" then
		local os = { "left", "right", "top", "bottom", "center" }
		local current = master.state.orientation
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
		master.state.orientation = os[idx]
	elseif command == "orientationprev" then
		local os = { "left", "right", "top", "bottom", "center" }
		local current = master.state.orientation
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
		master.state.orientation = os[idx]
	elseif command == "mfact" then
		local val = tonumber(params[1])
		if val then
			master.state.mfact = clamp(val, 0.05, 0.95)
		end
	elseif command == "addmaster" then
		-- Find the focused window (if possible) or the first slave
		local focused = get_focused_window(ctx)
		local target = nil

		-- Check if focused is a slave
		if focused and not master.state.windows[focused].is_master then
			target = focused
		else
			-- Fallback to first slave
			for _, win in ipairs(ctx.targets) do
				if not master.state.windows[win].is_master then
					target = win
					break
				end
			end
		end

		if target then
			master.state.windows[target].is_master = true
		end
	elseif command == "removemaster" then
		-- Similar logic to addmaster, find master to demote
		local focused = get_focused_window(ctx)
		local target = nil

		if focused and master.state.windows[focused].is_master and master.state.masters_count or 0 > 1 then
			target = focused
		else
			-- Fallback to last master
			for i = #ctx.targets, 1, -1 do
				local win = ctx.targets[i]
				if master.state.windows[win].is_master then
					target = win
					break
				end
			end
		end

		if target then
			-- Check if at least 2 masters to avoid leaving screen bare
			local m_count = 0
			for _, win in ipairs(ctx.targets) do
				if master.state.windows[win].is_master then
					m_count = m_count + 1
				end
			end

			if m_count > 1 then
				master.state.windows[target].is_master = false
			end
		end
	else
		return "unknown command: " .. command
	end

	return true
end

-- Register the layout
hl.layout.register(master.name, {
	recalculate = recalculate_master,
	layout_msg = handle_layout_msg,
})
