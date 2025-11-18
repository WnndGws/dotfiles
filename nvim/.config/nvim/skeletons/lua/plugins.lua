local Plugin = { "wnndgws/example" }

Plugin.dependencies = { "wnndgws/second_example" }

Plugin.lazy = true
Plugin.event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" }

Plugin.config = function()
	local plugin = require("example")
	plugin.setup({
		option_one = "whatever",
		longer_options = {
			one = "yes",
			two = "no",
		},
	})
end

return Plugin
