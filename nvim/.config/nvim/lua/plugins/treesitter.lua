local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.dependencies = { "mfussenegger/nvim-treehopper", "drybalka/tree-climber.nvim" }

Plugin.lazy = false
Plugin.branch = "master"
Plugin.build = ":TSUpdate"

Plugin.config = function()
	local plugin = require("nvim-treesitter")
	plugin.setup({
		ensure_installed = {
			"awk",
			"bash",
			"bibtex",
			"css",
			"dockerfile",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"html",
			"jinja",
			"jinja_inline",
			"jq",
			"json",
			"latex",
			"lua",
			"markdown",
			"printf",
			"python",
			"regex",
			"rust",
			"toml",
			"yaml",
			"zathurarc",
		},
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
	})
end

return Plugin
