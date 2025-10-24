return {
	"hisbaan/supertab.nvim",
	dependencies = {
		"L3MON4D3/LuaSnip",
	},
	lazy = false,
	keys = {
		{
			"<Tab>",
			function()
				require("supertab").trigger("<Tab>")
			end,
			mode = "i",
			desc = "Supertab",
		},
	},
	--- @module 'supertab'
	--- @type fun():supertab.Config
	opts = function()
		local luasnip = require("luasnip")

		return {
			keys = {
				["<Tab>"] = {
					{
						condition = function()
							return luasnip.expand_or_jumpable()
						end,
						action = function()
							luasnip.expand_or_jump()
						end,
					},
				},
			},
		}
	end,
}
