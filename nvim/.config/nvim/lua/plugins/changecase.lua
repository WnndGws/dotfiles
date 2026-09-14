return {
	"johmsalas/text-case.nvim",
	dependencies = {
		"folke/which-key.nvim",
	},
	opts = {
		prefix = "<leader>c",
	},
	config = function(_, opts)
		local plugin = require("textcase")
		plugin.setup(opts)

		local wk = require("which-key")
		wk.add({
			{
				"<leader>c",
				group = "Case Change",
				icon = {
					icon = "󱔎",
				},
				mode = { "n", "v" },
			},
		})
	end,
}
