return {
	"wnndgws/nvim-blocksort",
	config = function()
		require("blocksort")
	end,
	enabled = true,
	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
}
