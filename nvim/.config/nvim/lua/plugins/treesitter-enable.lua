return {
	"VonHeikemen/ts-enable.nvim",

	dependencies = { "nvim-treesitter/nvim-treesitter" },

	after = { "nvim-treesitter" },

	opts = function()
		return {
			auto_install = true,
			highlights = true,
			folds = false,
			indents = false,
		}
	end,
}
