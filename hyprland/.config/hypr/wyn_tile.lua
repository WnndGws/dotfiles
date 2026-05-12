--- Use wyn-master as inspiration to hand-write

local state = {
	name = "wyn",
	windows = {},
	split_ratio = 0.9,
}

local function clamp(v, lo, hi)
	return math.min(math.max(v, lo), hi)
end

local function recalculate_wyn(ctx)
	local targets = ctx.targets
	local n = #targets
	if n == 0 then
		return
	end

	local command = state.command
	state.command = nil

	for _, win in ipairs(targets) do
		local window = win.window
		local id = window and tostring(window.stable_id) or tostring(win.index)

		if not state.windows[id] then
			state.windows[id] = { win_id = nil, is_amm = false }
		end

		local data = state.windows[id]

		if command == "addwyn" then
			if data.win_id == nil then
				data.win_id = 1
			else
				data.win_id = data.win_id + 1
			end
			data.is_amm = false
		elseif command == "delwyn" then
			if data.win_id ~= nil then
				data.win_id = data.win_id - 1
			end
			data.is_amm = false
		end
	end

	local whole_rect = ctx.area
	local wyn_rect = {
		x = whole_rect.x,
		y = whole_rect.y,
		width = whole_rect.width * state.split_ratio,
		height = whole_rect.height,
	}
	local amm_rect = {
		x = whole_rect.x + wyn_rect.width,
		y = whole_rect.y,
		width = whole_rect.width - wyn_rect.width,
		height = whole_rect.height,
	}

	if n == 1 then
		targets[1]:place(whole_rect)
	else
		local wyn_target = nil
		local amm_windows = {}

		for _, win in ipairs(targets) do
			local window = win.window
			local id = window and tostring(window.stable_id) or tostring(win.index)
			local data = state.windows[id]

			if not wyn_target and data and data.win_id == 1 then
				wyn_target = win
			else
				table.insert(amm_windows, win)
			end
		end

		if not wyn_target then
			wyn_target = targets[1]
			amm_windows = {}
			for i = 2, n do
				table.insert(amm_windows, targets[i])
			end
		end

		wyn_target:place(wyn_rect)

		local num_amm = #amm_windows
		if num_amm > 0 then
			local current_rect = amm_rect
			local remaining = num_amm

			for _, win in ipairs(amm_windows) do
				local ratio = 1.0 / remaining
				if remaining > 1 then
					ratio = clamp(ratio, 0.05, 0.95)
				end

				local win_rect = ctx:split(current_rect, "top", ratio)
				local remainder_rect = ctx:split(current_rect, "bottom", 1.0 - ratio)
				win:place(win_rect)
				current_rect = remainder_rect
				remaining = remaining - 1
			end
		end
	end
end

hl.layout.register("wyn", {
	recalculate = recalculate_wyn,
	layout_msg = function(ctx, msg)
		local command = msg:match("^(%S+)")
		if command == "addwyn" or command == "delwyn" then
			state.command = command
		else
			return "wyn: expected addwyn or delwyn"
		end
		return true
	end,
})
