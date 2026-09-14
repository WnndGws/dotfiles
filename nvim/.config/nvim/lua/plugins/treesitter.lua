return {
	"nvim-treesitter/nvim-treesitter",

	dependencies = {
		"mfussenegger/nvim-treehopper",
		"drybalka/tree-climber.nvim",
		"nvim-treesitter/nvim-treesitter-context",
	},

	branch = "main",
	build = ":TSUpdate",

	config = function()
		local plugin = require("nvim-treesitter")
		plugin.setup({})
	end,
}
