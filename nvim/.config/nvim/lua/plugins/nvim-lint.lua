return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"folke/which-key.nvim",
	},
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			css = { "biomejs" },
			django = { "curlylint" },
			dotenv = { "dotenv-linter" },
			html = { "tidy" },
			javascript = { "biomejs", "snyk_iac" },
			jinja = { "curlylint" },
			json = { "jsonlint" },
			lua = {},
			makefile = { "checkmake" },
			markdown = { "markdownlint-cli2", "proselint", "woke" },
			openapi = { "vacuum" },
			python = { "pydocstyle", "ruff", "snyk_iac" },
			rust = { "snyk_iac" },
			systemd = { "systemd-analyze", "systemdlint" },
			tex = { "chktex" },
			text = {},
			toml = { "tombi" },
			typescript = { "biomejs", "snyk_iac" },
			vimscript = { "vint" },
			yaml = { "yamllint" },
		}

		lint.linters["markdownlint-cli2.args"] = {
			"--fix",
			"--config",
			vim.fn.expand("~/.config/nvim/markdownlint_conf.json"),
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
