return {
	"example/wnnd.nvim",
	dependencies = { "hrsh7th/cmp-emoji" },

	opts = {
		mappings = {
			add = "gsa",
			delete = "gsd",
		},
	},

	enabled = false,
	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
}
