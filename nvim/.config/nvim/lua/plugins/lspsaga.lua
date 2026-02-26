local Plugin = { "nvimdev/lspsaga.nvim" }

Plugin.dependencies = { "nvim-treesitter/nvim-treesitter" }

Plugin.lazy = true
Plugin.event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" }

Plugin.config = function()
	local plugin = require("lspsaga")
	plugin.setup({})
end

return Plugin
