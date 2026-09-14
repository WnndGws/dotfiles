-- bigbrother.lua — custom Hyprland layout (use as: layout = lua:bigbrother)
--
-- 0 windows: next window becomes the parent
-- 1 window:  parent is full-screen
-- 2 windows: parent takes mfact of the split, child the rest
-- 3+ :       parent takes mfact; child 1 takes the top of the other column
--            with (100 - (children-1)*CHILD)% of the stacking dimension;
--            remaining children are CHILD-tall slices stacked below.
--
-- layoutmsg commands: cyclenext, cycleprev (focus), swapnext, swapprev
-- (reorder), rollnext, rollprev, swapwithmaster, focusmaster, mfact,
-- orientationleft/right/top/bottom/next/prev/cycle.
--
-- Close behaviour: closing a child focuses the child above it; closing
-- the parent promotes child 1 to parent and focuses it.

-- "master {}" equivalents (the master: config section is NOT read by
-- lua layouts, so configure these here)
local CONFIG = {
	mfact = 0.5, -- parent share of the split, like master's mfact
	orientation = "left", -- left | right | top | bottom
}

local CHILD = 0.20 -- fraction of the stacking dimension per extra child

local state = { order = {}, targets = nil, focus_candidate = nil }

local function target_id(target)
	local window = target.window
	return window and tostring(window.stable_id) or tostring(target.index)
end

local function active_id(ctx)
	for _, target in ipairs(ctx.targets) do
		local window = target.window
		if window and window.active then
			return target_id(target)
		end
	end
	return state.order[#state.order]
end

local function index_of(list, val)
	for i, v in ipairs(list) do
		if v == val then
			return i
		end
	end
end

local function sync_order(ctx)
	local present, targets = {}, {}
	for _, t in ipairs(ctx.targets) do
		local id = target_id(t)
		present[id] = true
		targets[id] = t
	end

	state.focus_candidate = nil

	local old = state.order
	state.order = {}
	for idx, id in ipairs(old) do
		if present[id] then
			table.insert(state.order, id)
		elseif not state.focus_candidate then
			-- first closed window this pass: focus the child above it
			-- (idx - 1 in the compacted list); if the parent (idx 1)
			-- closed, that resolves to child 1, now the new parent
			local j = idx == 1 and 1 or idx - 1
			local newlist = {}
			for _, oid in ipairs(old) do
				if present[oid] then
					table.insert(newlist, oid)
				end
			end
			state.focus_candidate = newlist[j] or newlist[1]
		end
	end

	local focused = active_id(ctx)
	local after = focused and index_of(state.order, focused)
	for _, t in ipairs(ctx.targets) do
		local id = target_id(t)
		if not index_of(state.order, id) then
			table.insert(state.order, after and after + 1 or #state.order + 1, id)
			after = (after or #state.order - 1) + 1
		end
	end

	state.targets = targets
	return targets
end

-- split the work area into parent box and child-column box per orientation
local function split(a)
	local m = CONFIG.mfact
	local orient = CONFIG.orientation
	if orient == "right" then
		return { x = a.x + a.w * m, y = a.y, w = a.w * (1 - m), h = a.h }, { x = a.x, y = a.y, w = a.w * m, h = a.h }
	elseif orient == "top" then
		return { x = a.x, y = a.y, w = a.w, h = a.h * m }, { x = a.x, y = a.y + a.h * m, w = a.w, h = a.h * (1 - m) }
	elseif orient == "bottom" then
		return { x = a.x, y = a.y + a.h * (1 - m), w = a.w, h = a.h * m }, {
			x = a.x,
			y = a.y,
			w = a.w,
			h = a.h * (1 - m),
		}
	else -- left (default)
		return { x = a.x, y = a.y, w = a.w * m, h = a.h }, { x = a.x + a.w * m, y = a.y, w = a.w * (1 - m), h = a.h }
	end
end

local ORIENTS = { "left", "top", "right", "bottom" }

local function focus_index(j)
	local t = state.targets and state.targets[state.order[j]]
	local w = t and t.window
	if w then
		pcall(hl.dispatch, hl.dsp.focus({ window = w }))
	end
end

hl.layout.register("bigbrother", {
	recalculate = function(ctx)
		local targets = sync_order(ctx)
		local ids = state.order
		local n = #ids
		if n == 0 then
			return
		end

		-- apply close-behaviour focus before placing anything
		if state.focus_candidate then
			local t = targets[state.focus_candidate]
			local w = t and t.window
			if w and not w.active then
				pcall(hl.dispatch, hl.dsp.focus({ window = w }))
			end
			state.focus_candidate = nil
		end

		local a = ctx.area

		if n == 1 then
			targets[ids[1]]:place({ x = a.x, y = a.y, w = a.w, h = a.h })
			return
		end

		local parent, col = split(a)
		targets[ids[1]]:place(parent)

		-- stacking dimension: height for left/right, width for top/bottom
		local vertical = (CONFIG.orientation == "left" or CONFIG.orientation == "right")
		local stack = vertical and col.h or col.w
		local cross = vertical and col.w or col.h
		local extras = n - 2 -- children after the first
		local extraStack = stack * CHILD
		local firstStack = stack - extraStack * extras

		-- clamp: never let the first child's slice collapse to zero
		if extras > 0 and firstStack < stack / (extras + 1) then
			firstStack = stack / (extras + 1)
			extraStack = (stack - firstStack) / extras
		end

		local function place(i, along, s)
			local b = {
				x = col.x,
				y = col.y,
				w = vertical and cross or s,
				h = vertical and s or cross,
			}
			if vertical then
				b.y = col.y + along
			else
				b.x = col.x + along
			end
			targets[ids[i]]:place(b)
		end

		place(2, 0, firstStack)
		for i = 3, n do
			place(i, firstStack + extraStack * (i - 3), extraStack)
		end
	end,

	layout_msg = function(ctx, msg)
		local command, arg = msg:match("^(%S+)%s*(.-)%s*$")
		local id = active_id(ctx)
		local i = id and index_of(state.order, id)
		local n = #state.order

		local function swap(a, b)
			state.order[a], state.order[b] = state.order[b], state.order[a]
		end

		if command == "mfact" then
			-- plain float, relative "+0.2"/"-0.2", or "exact 0.6"
			local exact = arg:match("^exact%s+([%d%.]+)$")
			local rel = arg:match("^([%+%-])([%d%.]+)$")
			if exact then
				CONFIG.mfact = math.min(0.9, math.max(0.1, tonumber(exact) or CONFIG.mfact))
			elseif rel then
				local d = tonumber(arg:sub(2)) * (rel == "-" and -1 or 1)
				CONFIG.mfact = math.min(0.9, math.max(0.1, CONFIG.mfact + d))
			else
				local v = tonumber(arg)
				if v then
					CONFIG.mfact = math.min(0.9, math.max(0.1, v))
				end
			end
		elseif
			command == "orientationleft"
			or command == "orientationright"
			or command == "orientationtop"
			or command == "orientationbottom"
		then
			CONFIG.orientation = command:sub(12)
		elseif command == "orientationcenter" then
			return "pc: center orientation is not supported by bigbrother"
		elseif command == "orientationnext" or command == "orientationprev" then
			local cur = index_of(ORIENTS, CONFIG.orientation) or 1
			local d = command == "orientationnext" and 1 or -1
			CONFIG.orientation = ORIENTS[(cur - 1 + d) % #ORIENTS + 1]
		elseif command == "orientationcycle" then
			local list = {}
			for w in arg:gmatch("%S+") do
				if index_of(ORIENTS, w) then
					table.insert(list, w)
				end
			end
			if #list == 0 then
				list = ORIENTS
			end
			local cur = index_of(list, CONFIG.orientation) or #list
			CONFIG.orientation = list[cur % #list + 1]
		elseif command == "rollnext" then
			-- next window in stack becomes the parent
			if n >= 2 then
				table.insert(state.order, 1, table.remove(state.order, 2))
			end
		elseif command == "rollprev" then
			-- last window in stack becomes the parent
			if n >= 2 then
				table.insert(state.order, 1, table.remove(state.order, n))
			end
		elseif command == "swapwithmaster" then
			if arg:match("ignoremaster") and i == 1 then
				return true
			end
			if i and i ~= 1 then
				swap(1, i)
				if arg:match("master") then
					focus_index(1) -- focus follows the old parent into the stack
				end
			elseif i == 1 and n >= 2 then
				swap(1, 2)
				if arg:match("child") then
					focus_index(2)
				end
			end
		elseif command == "focusmaster" or command == "focusparent" then
			if n >= 1 then
				focus_index(1)
			end
		elseif command == "cyclenext" or command == "cycleprev" then
			-- moves focus only, like the built-in master layout
			if not i or n < 2 then
				return true
			end
			local d = command == "cyclenext" and 1 or -1
			local j = i + d
			if j < 1 or j > n then
				if arg == "noloop" then
					return true
				end
				j = (j - 1) % n + 1 -- loop is the default
			end
			focus_index(j)
		elseif command == "swapnext" or command == "swapprev" then
			-- reorders windows, focus stays put
			if not i or n < 2 then
				return true
			end
			local d = command == "swapnext" and 1 or -1
			local j = i + d
			if j < 1 or j > n then
				if arg == "noloop" then
					return true
				end
				j = (j - 1) % n + 1 -- loop default
			end
			swap(i, j)
		elseif command == "addmaster" or command == "removemaster" then
			return "pc: bigbrother has a single parent; addmaster/removemaster are unsupported"
		else
			return "pc: expected mfact, orientation*, rollnext, rollprev, swapwithmaster, focusmaster, cyclenext, cycleprev, swapnext, or swapprev"
		end
		return true
	end,
})
