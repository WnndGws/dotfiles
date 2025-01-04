local Plugin = { "mfussenegger/nvim-lint" }

Plugin.event = { "BufReadPre", "BufNewFile" }
Plugin.config = function()
	local linterConfig = vim.fn.stdpath("config") .. ".linter_configs"
	local lint = require("lint")
	local linters = require("lint").linters

	lint.linters_by_ft = {
		["*"] = { "commitlint", "systemdlint", "typos" },
		css = { "stylelint" },
		gitcommit = {},
		html = { "htmlhint", "tidy" },
		javascript = { "biomejs" },
		json = { "biomejs", "jsonlint" },
		lua = { "luacheck" },
		markdown = { "markdownlint-cli2" },
		python = { "vulture", "bandit", "mypy", "pydocstyle", "ruff" },
		sh = { "shellcheck", "zsh" },
		tex = { "chktex" },
		text = { "alex", "proselint" },
		toml = {},
		typescript = { "biomejs" },
		yaml = { "yamllint" },
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})

	linters.mypy.args = {
		"--ignore-missing-imports",
	}

	linters.shellcheck.args = {
		"--shell=bash", -- force to work with zsh
		"--format=json",
		"-",
	}

	linters.yamllint.args = {
		"--config-file",
		linterConfig .. "/yamllint.yaml",
		"--format=parsable",
		"-",
	}

	linters.markdownlint.args = {
		"--disable=no-trailing-spaces", -- not disabled in config, so it's enabled for formatting
		"--disable=no-multiple-blanks",
		"--config=" .. linterConfig .. "/markdownlint.yaml",
	}
end

return Plugin
