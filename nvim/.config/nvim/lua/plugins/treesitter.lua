local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.dependencies = {
	"mfussenegger/nvim-treehopper",
	"drybalka/tree-climber.nvim",
	"nvim-treesitter/nvim-treesitter-context",
	"OXY2DEV/markview.nvim",
}

Plugin.lazy = false
Plugin.after = { "markview" }
Plugin.branch = "main"
Plugin.build = ":TSUpdate"

Plugin.config = function()
	local plugin = require("nvim-treesitter")
	plugin.setup({})
end

return Plugin
