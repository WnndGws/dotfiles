local Plugin = { "folke/which-key.nvim" }

Plugin.event = "VeryLazy"
Plugin.opts = {
	plugins = { spelling = true },
	defaults = {
		mode = { "n", "v" },
		["<leader>-"] = { name = "+dial" },
		["<leader><tab>"] = { name = "+tabs" },
		["<leader>a"] = { name = "+aerial" },
		["<leader>b"] = { name = "+buffer" },
		["<leader>f"] = { name = "+file/find" },
		["<leader>e"] = { name = "+tree" },
		["<leader>q"] = { name = "+quit/session" },
		["<leader>s"] = { name = "+wiki search" },
		["<leader>w"] = { name = "+write" },
		["<leader>x"] = { name = "+wiki" },
		["["] = { name = "+prev" },
		["]"] = { name = "+next" },
		["g"] = { name = "+goto" },
		["gs"] = { name = "+surround" },
		["z"] = { name = "+fold" },
	},
}
Plugin.config = function(_, opts)
	local wk = require("which-key")
	wk.setup(opts)
	wk.register(opts.defaults)
end

return Plugin
