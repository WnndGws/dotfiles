return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				bash = { "beautysh", "shellharden" },
				sh = { "beautysh", "shellharden" },
				zsh = { "beautysh", "shellharden" },
				latex = { "bibtex-tidy", "latexindent", "tex-fmt" },
				json = { "biome", "fixjson", "jq", "prettier" },
				javascript = { "biome", "prettier", "rustywind" },
				typescript = { "biome", "rustywind" },
				markdown = { "markdownlint-cli2", "mdslw", "prettier" },
				python = { "docformatter", "ruff_format" },
				angular = { "prettier", "rustywind" },
				css = { "prettier", "rustywind" },
				html = { "prettier", "rustywind" },
				yaml = { "prettier", "yamlfix", "yamlfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
		})
	end,
}
