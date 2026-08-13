return {
	"terryma/vim-expand-region",
	enabled = true,
	lazy = true,

	dependencies = {
		"folke/which-key.nvim",
	},

	keys = {
		{
			mode = { "v" },
			"v",
			"<Plug>(expand_region_expand)",
			desc = "Expand selection",
		},
		{
			mode = { "v" },
			"<leader>?v",
			"<Plug>(expand_region_expand)",
			desc = "Expand selection",
		},
	},

	init = function()
		-- Extend the default dictionary with extra text objects
		vim.g.expand_region_text_objects = {
			iw = 0,
			iW = 0,
			['i"'] = 0,
			["i'"] = 0,
			["i]"] = 1, -- nesting supported
			ib = 1,
			iB = 1,
			il = 0,
			ip = 0,
			ie = 0,
			-- add my extra delimiters here
			["i`"] = 0, -- inside backticks
			["i)"] = 0, -- inside brackets
			["i>"] = 0, -- inside angled brackets
			["i}"] = 0, -- inside curly brackets
			["i,"] = 0, -- inside commas
			ii = 0, -- inside indent
		}
	end,
}
