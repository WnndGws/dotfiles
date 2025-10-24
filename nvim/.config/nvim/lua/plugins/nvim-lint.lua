return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			rust = { "snyk_iac" },
			python = { "bandit", "pydocstyle", "ruff", "snyk_iac", "vulture" },
			json = { "jsonlint" },
			javascript = { "biome", "snyk_iac" },
			typescript = { "biome", "snyk_iac" },
			makefile = { "checkmake" },
			django = { "curlylint" },
			jinja = { "curlylint", "jinja-lsp" },
			dotenv = { "dotenv-linter" },
			html = { "html" },
			lua = {},
			markdown = { "markdownlint-cli2", "proselint", "woke" },
			bash = { "bash", "shellcheck" },
			sh = { "shellcheck" },
			zsh = { "zsh", "shellcheck" },
			css = { "stylelint" },
			systemd = { "systemd-analyze", "systemdlint" },
			openapi = { "vacuum" },
			vimscript = { "vint" },
			yaml = { "yamllint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
