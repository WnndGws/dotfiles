return {
	"stevearc/aerial.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "onsails/lspkind.nvim" },

	opts = {
		backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
		show_guides = true,
		open_automatic = true,
	},

	enabled = true,
	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
}
