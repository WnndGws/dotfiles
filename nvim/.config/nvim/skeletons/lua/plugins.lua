local Plugin = { "monaqa/dial.nvim" }

Plugin.dependencies = {}
Plugin.lazy = false

Plugin.event = { "BufReadPost", "BufNewFile", "BufWritePre" }

Plugin.opts = function()
	local dial = require("dial")
	dial.setup({
		setting = { setting2 = "string" },
	})
end

return Plugin
