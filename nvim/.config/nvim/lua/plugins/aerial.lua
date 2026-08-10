return {
	"stevearc/aerial.nvim",
	enabled = true,
	dependencies = { "nvim-tree/nvim-web-devicons", "onsails/lspkind.nvim", "folke/which-key.nvim" },

	opts = {
		backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
		show_guides = true,
		open_automatic = false,
	},

	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },

	keys = {
		{
			mode = { "n" },
			"<leader>aa",
			":AerialToggle<CR>",
			desc = "Toggle Aerial open or closed",
		},
	},

	config = function(_, opts)
		require("aerial").setup(opts)

		local wk = require("which-key")
		wk.add({
			{ "<leader>a", group = "Aerial", icon = "󰠿" },
		})
	end,
}
