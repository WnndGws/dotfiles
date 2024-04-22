local Plugin = { "echasnovski/mini.pairs" }

Plugin.event = "VeryLazy"

Plugin.config = function()
	local pairs = require("mini.pairs")
	pairs.setup({
		mappings = {
			["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
		},
	})
end

Plugin.keys = {
	{
		"<leader>up",
		function()
			vim.g.minipairs_disable = not vim.g.minipairs_disable
		end,
		desc = "Toggle Auto Pairs",
	},
}

return Plugin
