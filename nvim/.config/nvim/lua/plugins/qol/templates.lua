local Plugin = { "nvimdev/template.nvim" }

Plugin.event = "VeryLazy"
Plugin.cmd = { "Template", "TemProject" }

Plugin.config = function()
	local template = require("template")
	template.setup({
		temp_dir = "/home/wynand/.config/nvim/templates",
		author = "Wynand Gouws",
		email = "wynand@gouws.com.au",
	})
end

return Plugin
