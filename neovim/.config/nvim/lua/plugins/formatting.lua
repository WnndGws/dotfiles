------------------------------------------------------------------
local Plugin = { "stevearc/conform.nvim" }
------------------------------------------------------------------

Plugin.lazy = true
Plugin.cmd = { "ConformInfo" }
Plugin.event = { "BufWritePre" }

Plugin.config = function()
	local conform = require("conform")
	conform.setup({
		-- Define your formatters
		formatters_by_ft = {
			["*"] = { "trim_newlines", "trim_whitespace" },
			awk = { "awk" },
			css = { "rustywind", "stylelint" },
			html = { "htmlbeautifier" },
			javascript = { "ast-grep" },
			json = { "fixjson" },
			lua = { "stylua" },
			markdown = { "markdown-toc", "mdformat" },
			python = { "isort", "ruff_format", "ruff_fix", "ast-grep" },
			rust = { "ast-grep" },
			sh = { "beautysh", "shellcheck", "shellharden" },
			tex = { "bibtex-tidy", "latexindent" },
			typescript = { "ast-grep" },
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
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
