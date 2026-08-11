return {
	"charm-and-friends/freeze.nvim",
	dependencies = {
		"folke/which-key.nvim",
	},
	keys = {
		{
			mode = { "n", "v" },
			"<leader>fa",
			":Freeze<CR>",
			desc = "Freeze code to ./%Y-%m-%d_freeze.png",
		},
	},
	config = function()
		require("freeze").setup({
			command = "freeze",
			open = false, -- Open the generated image after running the command
			output = function()
				return "/home/wynand/" .. os.date("%Y-%m-%d") .. "_freeze.png"
			end,
			theme = "catppuccin-mocha",
			window = true,
			show_line_numbers = true,
		})

		local wk = require("which-key")
		wk.add({
			{ "<leader>f", group = "Freeze", icon = "" },
		})
	end,
}
