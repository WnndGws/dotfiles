return {
	"danymat/neogen",
	opts = {
		snippet_engine = "luasnip",
		languages = {
			python = {
				template = {
					annotation_convention = "reST",
				},
			},
			lua = {
				template = {
					annotation_convention = "ldoc",
				},
			},
		},
	},

	enabled = true,
	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
	keys = {
		{
			mode = { "n" },
			"<leader>d",
			":Neogen<CR>",
			desc = "Insert a standardised docstring",
		},
	},

	config = function(_, opts)
		require("neogen").setup(opts)

		local wk = require("which-key")
		wk.add({
			{ "<leader>d", icon = "󱪝" },
		})
	end,
}
