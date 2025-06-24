local Plugin = { "lukas-reineke/indent-blankline.nvim" }

Plugin.event = "VeryLazy"
Plugin.main = "ibl"
Plugin.config = function()
	local blankline = require("ibl")
	blankline.setup({
		indent = {
			char = "│",

			tab_char = "│",
		},
		scope = { enabled = false },
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
		},
	})
end

return Plugin
