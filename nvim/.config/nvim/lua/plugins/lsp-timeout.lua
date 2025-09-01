return {
	"hinell/lsp-timeout.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	init = function()
		vim.g.lspTimeoutConfig = {
			stopTimeout = 1000 * 60 * 5, -- ms, timeout before stopping all LSPs
			startTimeout = 1000 * 10, -- ms, timeout before restart
			silent = false, -- true to suppress notifications
		}
	end,
}
