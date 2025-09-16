return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				awk = { "gawk" },
				angular = { "rustywind" },
				bash = { "beautysh", "shellharden", "shellcheck" },
				css = { "rustywind", "stylelint" },
				html = { "rustywind", "html_beautify" },
				javascript = { "rustywind" },
				json = { "jq", "fixjson" },
				tex = { "bibtex-tidy", "tex-fmt" },
				lua = { "stylua" },
				markdown = { "markdownlint-cli2", "mdslw" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports", "pyupgrade" },
				sh = { "beautysh", "shellharden", "shellcheck" },
				typescript = { "rustywind" },
				yaml = { "yamlfix", "yamlfmt" },
				zsh = { "beautysh", "shellharden", "shellcheck" },
			},
			format_on_save = {
				lsp_format = "fallback",
				async = false,
				timeout_ms = 5000,
			},
		})
	end,
}
