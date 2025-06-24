local Plugin = { "windwp/nvim-ts-autotag" }

Plugin.lazy = false
Plugin.main = "nvim-treesitter.configs"
Plugin.opts = {
	enable_close = true,
	enable_rename = true,
	enable_close_on_slash = true,
}

Plugin.config = function()
	local plugin = require("nvim-ts-autotag")
	plugin.setup({})
end

return Plugin
