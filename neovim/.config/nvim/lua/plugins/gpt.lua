local Plugin = { "Robitx/gp.nvim" }

function Plugin.config()
	local gp = require("gp")

	-- See :help cmp-config
	gp.setup({
		openai_api_key = os.getenv("OPENAI_API_KEY"),
	})
end

return Plugin
