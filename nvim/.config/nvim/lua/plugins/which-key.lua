local Plugin = { "folke/which-key.nvim" }

Plugin.event = { "BufWritePre", "BufReadPre", "BufNewFile" }

Plugin.opts_extend = { "spec" }
Plugin.opts = function()
	local preset = "helix"
	local spec = {
		{
			"<leader>b",
			group = "buffer",
			expand = function()
				return require("which-key.extras").expand.buf()
			end,
		},
	}
end

Plugin.config = function(_, opts)
	local wk = require("which-key")
	wk.add({
		{ "<leader>-", group = "Dial" },
		{ "<leader>b", group = "Checkbox" },
		{ "<leader>h", group = "Hop" },
		{ "<leader>l", group = "Linting" },
		{ "<leader>o", group = "Outline" },
		{ "<leader>s", group = "SnipRun" },
		{ "<leader>r", group = "Surround" },
		{ "<leader>t", group = "Telescope" },
		{ "<leader>g", group = "Git" },
		{ "<leader>w", group = "Write File" },
	})
	wk.setup(opts)
end

return Plugin
