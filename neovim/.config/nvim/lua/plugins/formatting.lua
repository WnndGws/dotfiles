------------------------------------------------------------------
local Plugin = { "stevearc/conform.nvim" }
------------------------------------------------------------------

Plugin.lazy = true
Plugin.cmd = { "ConformInfo" }
Plugin.event = { "BufWritePre", "BufReadPre", "BufNewFile" }

Plugin.config = function()
	local conform = require("conform")
	conform.setup({
		-- Define your formatters
		formatters_by_ft = {
			["*"] = { "trim_newlines", "trim_whitespace" },
			awk = { "awk" },
			css = { "rustywind", "stylelint", "prettier" },
			html = { "htmlbeautifier", "prettier" },
			javascript = { "ast-grep", "prettier" },
			json = { "fixjson", "prettier" },
			lua = { "stylua" },
			markdown = { "markdown-toc", "prettier" },
			python = { "ast-grep", "isort", "ruff_format", "ruff_fix", "mypy" },
			rust = { "ast-grep" },
			sh = { "beautysh", "shellcheck", "shellharden" },
			bib = { "bibtex-tidy" },
			tex = { "latexindent" },
			typescript = { "ast-grep", "prettier" },
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500, lsp_fallback = true, async = false },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
			prettier = {
				tabWidth = 4,
			},
		},
	})
end

Plugin.init = function()
	-- If you want the formatexpr, here is the place to set it
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

------------------------------------------------------------------
return Plugin
------------------------------------------------------------------
