local Plugin = { "monaqa/dial.nvim" }

Plugin.event = { "BufReadPost", "BufNewFile", "BufWritePre" }

Plugin.opts = function()
	local augend = require("dial.augend")

	local logical_alias = augend.constant.new({
		elements = { "&&", "||" },
		word = false,
		cyclic = true,
	})

	local ordinal_numbers = augend.constant.new({
		-- elements through which we cycle. When we increment, we go down
		-- On decrement we go up
		elements = {
			"first",
			"second",
			"third",
			"fourth",
			"fifth",
			"sixth",
			"seventh",
			"eighth",
			"ninth",
			"tenth",
		},
		-- if true, it only matches strings with word boundary. firstDate wouldn't work for example
		word = false,
		-- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
		-- Otherwise nothing will happen when there are no further values
		cyclic = true,
	})

	local weekdays = augend.constant.new({
		elements = {
			"Mon",
			"Tue",
			"Wed",
			"Thu",
			"Fri",
			"Sat",
			"Sun",
		},
		word = true,
		cyclic = true,
	})

	local weekdays_full = augend.constant.new({
		elements = {
			"Monday",
			"Tuesday",
			"Wednesday",
			"Thursday",
			"Friday",
			"Saturday",
			"Sunday",
		},
		word = true,
		cyclic = true,
	})

	local months = augend.constant.new({
		elements = {
			"Jan",
			"Feb",
			"Mar",
			"Apr",
			"May",
			"Jun",
			"Jul",
			"Aug",
			"Sep",
			"Oct",
			"Nov",
			"Dec",
		},
		word = true,
		cyclic = true,
	})

	local months_full = augend.constant.new({
		elements = {
			"January",
			"February",
			"March",
			"April",
			"May",
			"June",
			"July",
			"August",
			"September",
			"October",
			"November",
			"December",
		},
		word = true,
		cyclic = true,
	})

	local capitalized_boolean = augend.constant.new({
		elements = {
			"True",
			"False",
		},
		word = true,
		cyclic = true,
	})

	return {
		groups = {
			default = {
				augend.integer.alias.decimal,
				augend.integer.alias.decimal_int,
				augend.integer.alias.binary,
				logical_alias,
				ordinal_numbers,
				weekdays,
				weekdays_full,
				months,
				months_full,
				capitalized_boolean,
				augend.constant.alias.bool,
				augend.constant.alias.alpha,
				augend.constant.alias.Alpha,
				augend.date.alias["%Y/%m/%d"],
				augend.date.alias["%d/%m/%Y"],
				augend.date.alias["%Y-%m-%d"],
				augend.date.alias["%d-%m-%Y"],
			},
		},
	}
end

Plugin.config = function(_, opts)
	for name, group in pairs(opts.groups) do
		if name ~= "default" then
			vim.list_extend(group, opts.groups.default)
		end
	end
	require("dial.config").augends:register_group(opts.groups)
	vim.g.dials_by_ft = opts.dials_by_ft
end

return Plugin
