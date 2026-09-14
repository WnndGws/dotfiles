return {
	"hedyhli/outline.nvim",
	enabled = true,

	keys = {
		{
			mode = { "n" },
			"<leader>aa",
			":Outline<CR>",
			desc = "Show code Outline",
		},
	},

	opts = {
		outline_items = {
			show_symbol_lineno = true,
			auto_update_events = {
				follow = { "CursorMoved" },
			},
		},
	},

	config = function(_, opts)
		require("outline").setup(opts)

		local wk = require("which-key")
		wk.add({
			{ "<leader>a", group = "Outline", icon = "" },
		})
	end,
}
