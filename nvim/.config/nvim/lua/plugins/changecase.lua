local Plugin = { "johmsalas/text-case.nvim" }

Plugin.lazy = false

Plugin.config = function()
	local plugin = require("textcase")
	plugin.setup({})
end

return Plugin
