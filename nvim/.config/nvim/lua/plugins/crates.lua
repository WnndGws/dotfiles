return {
	"Saecki/crates.nvim",
	lazy = true,
	event = { "BufRead Cargo.toml" },
	opts = {
		completion = {
			crates = {
				enabled = true,
			},
		},
		lsp = {
			enabled = true,
			actions = true,
			completion = true,
			hover = true,
		},
	},
}
