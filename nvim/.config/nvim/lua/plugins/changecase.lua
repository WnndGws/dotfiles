return {
	"johmsalas/text-case.nvim",
	lazy = false,
	opts = {
		prefix = "<leader>c",
	},
	config = function(_, opts)
		local plugin = require("textcase")
		plugin.setup(opts)

		local wk = require("which-key")
		wk.add({
			{ "<leader>c", group = "Case Change", icon = "󱔎", mode = { "n", "v" } },
		})
	end,
}
