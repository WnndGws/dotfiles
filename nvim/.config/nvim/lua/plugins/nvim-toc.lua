local Plugin = { "wnndgws/nvim-toc" }

Plugin.config = function()
	local yanky = require("nvim-toc")
	yanky.setup({
		toc_header = "Table of Contents",
	})
end

return Plugin
