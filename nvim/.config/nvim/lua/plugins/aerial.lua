return {
	"stevearc/aerial.nvim",
	enabled = true,
	dependencies = { "nvim-tree/nvim-web-devicons", "onsails/lspkind.nvim" },

	opts = {
		backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
		show_guides = true,
		open_automatic = false,
	},

	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
}
