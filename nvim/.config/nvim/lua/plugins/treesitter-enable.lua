local Plugin = { "VonHeikemen/ts-enable.nvim" }

Plugin.dependencies = { "nvim-treesitter/nvim-treesitter" }

Plugin.lazy = false
Plugin.after = { "nvim-treesitter" }

Plugin.opts = function()
	return {
		auto_install = true,
		highlights = true,
		folds = false,
		indents = false,
	}
end

return Plugin
