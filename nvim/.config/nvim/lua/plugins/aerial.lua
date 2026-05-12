return {
	"stevearc/aerial.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "onsails/lspkind.nvim" },

	opts = {
		backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
		show_guides = true,
		open_automatic = true,
	},

	enabled = false,
	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
}
