local Plugin = { "folke/which-key.nvim" }

Plugin.event = { "BufWritePre", "BufReadPre", "BufNewFile" }

Plugin.opts_extend = { "spec" }
Plugin.opts = function()
	local preset = "helix"
	local triggers = {
		{ "<auto>", mode = "nixsotc" },
		{ "a", mode = { "n", "v" } },
	}
end

Plugin.config = function(_, opts)
	local wk = require("which-key")
	wk.add({
		{ "<leader>?", group = "Help for non-leader keybinds" },
		{ "<leader>-", group = "Dial" },
		{ "<leader>a", group = "Aerial Toggle" },
		-- { "<leader>b", group = "Checkbox" }, ## USED FOR BUFFERS
		{ "<leader>c", group = "Checkbox", icon = "" },
		-- { "<leader>d", group = "Checkbox" },
		{ "<leader>e", group = "Nvim-Tree" },
		{ "<leader>f", group = "Freeze Code" },
		{ "<leader>g", group = "Git" },
		{ "<leader>h", group = "Hop" },
		-- { "<leader>i", group = "Checkbox" },
		-- { "<leader>j", group = "Checkbox" },
		-- { "<leader>k", group = "Checkbox" },
		{ "<leader>l", group = "Linting" },
		{ "<leader>m", group = "Markdown" },
		-- { "<leader>n", group = "Checkbox" },
		-- { "<leader>o", group = "Outline" },
		-- { "<leader>p", group = "Checkbox" },
		-- { "<leader>q", group = "Checkbox" },
		{ "<leader>r", group = "Surround" },
		{ "<leader>s", group = "SnipRun" },
		{ "<leader>t", group = "Telescope" },
		{ "<leader>u", group = "Undo" },
		-- { "<leader>v", group = "Checkbox" },
		{ "<leader>w", group = "Write File" },
		-- { "<leader>x", group = "Checkbox" },
		-- { "<leader>y", group = "Checkbox" },
		{ "<leader>z", group = "Folds" },
	})
	wk.setup(opts)
end

return Plugin
