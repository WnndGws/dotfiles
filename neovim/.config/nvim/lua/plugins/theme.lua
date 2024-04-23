---------------------
--- COLOUR SCHEME ---
---------------------
local Plugin = { "folke/tokyonight.nvim" }

Plugin.lazy = false
Plugin.priority = 1000
Plugin.config = function()
	local tokyo = require("tokyonight")
	tokyo.setup({
		transparent = true,
		style = "storm",
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
	})
	vim.cmd("colorscheme tokyonight")
end

return Plugin
