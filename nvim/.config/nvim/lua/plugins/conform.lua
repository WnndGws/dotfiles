return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufReadPre", "BufNewFile" },
	lazy = false,
	keys = {
		-- No which-key needed
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				angular = { "rustywind", "prettier" },
				awk = { "gawk" },
				bash = { "beautysh", "shellharden", "shellcheck" },
				css = { "rustywind", "stylelint", "prettier" },
				html = { "djlint", "rustywind", "html_beautify", "prettier" },
				javascript = { "rustywind", "prettier" },
				jinja = { "djlint" },
				json = { "jq", "fixjson", "prettier" },
				latex = { "tex-fmt", "latexindent" },
				lua = { "stylua" },
				markdown = { "markdownlint-cli2", "mdslw", "prettier" },
				python = { "pyupgrade", "ruff_fix", "ruff_format", "ruff_organize_imports" },
				sh = { "beautysh", "shellharden", "shellcheck" },
				tex = { "bibtex-tidy", "tex-fmt", "latexindent" },
				toml = { "taplo" },
				typescript = { "rustywind", "prettier" },
				xml = { "xmlstarlet" },
				yaml = { "yamlfix", "yamlfmt", "prettier" },
				zsh = { "beautysh", "shellharden", "shellcheck" },
			},
			formatters = {
				["markdownlint-cli2"] = {
					args = {
						"--fix",
						"--config",
						vim.fn.expand("~/.config/nvim/markdownlint_conf.json"),
					},
				},
				["prettier"] = {
					args = {
						"--tab-width",
						"4",
						"--prose-wrap",
						"always",
						"--write",
					},
				},
				["pyupgrade"] = {
					command = "pyupgrade",
					args = { "--py315-plus" },
					stdin = false,
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
