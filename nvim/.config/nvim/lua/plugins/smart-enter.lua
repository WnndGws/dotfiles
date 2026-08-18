return {
	"Chiarandini/smart-enter.nvim",
	event = "InsertEnter",
	opts = {
		filetypes = {
			markdown = { preset = "markdown" },
			tex = { preset = "latex" },
		},
	},
	config = function(_, opts)
		require("smart_enter").setup(opts)
	end,
}
