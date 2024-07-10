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
		["<leader>d"] = { name = "+delete all marks" },
		["<leader>g"] = { name = "+git/fugitive" },
		["<leader>f"] = { name = "+file/find" },
		["<leader>e"] = { name = "+tree" },
		["<leader>q"] = { name = "+quit/session" },
		["<leader>t"] = { name = "+tablemode" },
		["<leader>u"] = { name = "+treesitter" },
		["<leader>w"] = { name = "+write" },
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
    wk.register({
        opts.defaults,
    })
end

return Plugin
