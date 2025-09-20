local Plugin = { "cvigilv/esqueleto.nvim" }

Plugin.config = function()
	local plugin = require("esqueleto")

	plugin.setup({
		patterns = { "LICENSE", "python", "markdown", "sh", "lua" },
	})
end

return Plugin
