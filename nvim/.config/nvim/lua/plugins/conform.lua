return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufReadPre", "BufNewFile" },
	keys = {
		-- No which-key needed
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				awk = { "gawk" },
				angular = { "rustywind", "prettier" },
				bash = { "beautysh", "shellharden", "shellcheck" },
				css = { "rustywind", "stylelint", "prettier" },
				html = { "rustywind", "html_beautify", "prettier" },
				javascript = { "rustywind", "prettier" },
				json = { "jq", "fixjson", "prettier" },
				tex = { "bibtex-tidy", "tex-fmt" },
				lua = { "stylua" },
				markdown = { "markdownlint-cli2", "mdslw", "prettier" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				sh = { "beautysh", "shellharden", "shellcheck" },
				typescript = { "rustywind", "prettier" },
				xml = { "xmlstarlet" },
				yaml = { "yamlfix", "yamlfmt", "prettier" },
				zsh = { "beautysh", "shellharden", "shellcheck" },
			},
			formatters = {
				["markdownlint-cli2"] = {
					"--fix",
					"--config",
					vim.fn.expand("~/.config/nvim/markdownlint_conf.json"),
				},
				["prettier"] = {
					"--tab-width 4",
					"--prose-wrap always",
					"--write",
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
