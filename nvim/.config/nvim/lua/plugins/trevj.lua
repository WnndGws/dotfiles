return {
	"AckslD/nvim-trevJ.lua",

	enabled = true,

	keys = {
		{
			mode = { "n", "x" },
			"S",
			function()
				require("trevj").format_at_cursor()
			end,
			desc = "Seperate line",
		},
	},

	config = function()
		require("trevj").setup()
	end,
}
