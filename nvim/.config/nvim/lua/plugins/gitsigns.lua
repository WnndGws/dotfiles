local Plugin = { "lewis6991/gitsigns.nvim" }

Plugin.event = "VeryLazy"
Plugin.config = function()
	local gitsign = require("gitsigns")
	gitsign.setup({
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "-" },
			topdelete = { text = "-" },
			changedelete = { text = "-" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		word_diff = true,
	})
end

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#4fd6be" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff757f" })
vim.api.nvim_set_hl(0, "GitSignsTopDelete", { fg = "#ff757f" })
vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { fg = "#ff757f" })
vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#737aa2" })

return Plugin
