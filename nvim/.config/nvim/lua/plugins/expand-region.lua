return {
	"wnndgws/nvim-expand-region",
	enabled = true,
	lazy = true,

	keys = {
		{
			mode = { "v" },
			"v",
			function()
				require("expand_region").expand()
			end,
			desc = "Expand region",
		},
		{
			mode = { "n", "x" },
			"<leader>er",
			function()
				require("expand_region").expand()
			end,
			desc = "Expand region",
		},
		{
			mode = { "n", "x" },
			"<leader>sr",
			function()
				require("expand_region").shrink()
			end,
			desc = "Shrink region",
		},
	},

	config = function(_, opts)
		require("expand_region").setup(opts)
	end,
}
