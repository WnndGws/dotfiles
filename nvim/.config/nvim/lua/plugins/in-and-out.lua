return {
	"ysmb-wtsg/in-and-out.nvim",
	dependencies = {
		"folke/which-key.nvim",
	},
	keys = {
		{
			"<C-CR>",
			function()
				require("in-and-out").in_and_out()
			end,
			mode = { "i", "v", "n" },
			desc = "Jump in and out of pairs",
		},
	},
}
