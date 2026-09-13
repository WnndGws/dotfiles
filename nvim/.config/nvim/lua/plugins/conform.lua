return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				angular = { "rustywind", "prettier" },
				awk = { "gawk" },
				bash = { "shuck" },
				css = { "rustywind", "stylelint", "prettier" },
				html = { "djlint", "rustywind", "html_beautify", "prettier" },
				javascript = { "rustywind", "prettier" },
				jinja = { "djlint" },
				json = { "jq", "fixjson", "prettier" },
				latex = { "tex-fmt", "latexindent" },
				lua = { "stylua" },
				markdown = { "markdownlint-cli2", "mdslw", "prettier" },
				python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
				sh = { "shuck" },
				tex = { "bibtex-tidy", "tex-fmt", "latexindent" },
				toml = { "taplo" },
				typescript = { "rustywind", "prettier" },
				xml = { "xmlstarlet" },
				yaml = { "yamlfmt", "prettier" },
				zsh = { "shuck" },
			},
			formatters = {
				["markdownlint-cli2"] = {
					args = {
						"--fix",
						"--config",
						vim.fn.expand("~/.config/nvim/markdownlint_conf.json"),
					},
				},
				prettier = {
					args = { "--tab-width", "4", "--prose-wrap", "always" },
				},
				pyupgrade = {
					args = { "--py314-plus" },
				},
			},
			format_on_save = {
				lsp_format = "fallback",
				async = false,
				timeout_ms = 5000,
			},
		})
	end,
}
