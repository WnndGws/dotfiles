return {
	"wnndgws/nvim-blocksort",
	config = function()
		require("blocksort")
	end,
	enabled = true,
	lazy = true,
	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
}
