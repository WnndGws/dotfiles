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
			python = { "bandit", "pydocstyle", "ruff", "snyk_iac" },
			json = { "jsonlint" },
			javascript = { "biomejs", "snyk_iac" },
			typescript = { "biomejs", "snyk_iac" },
			makefile = { "checkmake" },
			django = { "curlylint" },
			jinja = { "curlylint" },
			dotenv = { "dotenv-linter" },
			html = { "tidy" },
			lua = {},
			markdown = { "markdownlint-cli2", "proselint", "woke" },
			bash = { "bash", "shellcheck" },
			sh = { "shellcheck" },
			zsh = { "zsh", "shellcheck" },
			css = { "biomejs" },
			systemd = { "systemd-analyze", "systemdlint" },
			openapi = { "vacuum" },
			vimscript = { "vint" },
			yaml = { "yamllint" },
			toml = { "tombi" },
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
