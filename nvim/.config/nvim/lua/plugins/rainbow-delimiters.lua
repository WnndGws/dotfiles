return {
	"HiPhish/rainbow-delimiters.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},

	enabled = true,

	opts = {},

	config = function(_, opts)
		require("rainbow-delimiters.setup").setup(opts)
	end,
}
