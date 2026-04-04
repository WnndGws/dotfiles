return {
	"danymat/neogen",

	opts = {
		snippet_engine = "luasnip",
		languages = {
			python = { template = { annotation_convention = "google_docstrings" } },
			sh = { annotation_convention = "google_bash" },
			lua = { annotation_convention = "emmylua" },
		},
	},

	enabled = true,
	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
}
