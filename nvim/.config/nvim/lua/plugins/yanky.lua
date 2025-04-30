local Plugin = { "gbprod/yanky.nvim" }

Plugin.dependencies = {
	{ "kkharji/sqlite.lua" },
}
Plugin.config = function()
	local yanky = require("yanky")
	yanky.setup({
		ring = { storage = "sqlite" },
	})
end

return Plugin
