Plugin = { "andythigpen/nvim-coverage" }

Plugin.event = "VeryLazy"
Plugin.dependencies = { "nvim-lua/plenary.nvim" }
Plugin.config = function()
	local coverage = require("coverage")
	coverage.setup({
		commands = true, -- create commands

		highlights = {
			-- customize highlight groups created by the plugin
			covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
			uncovered = { fg = "#F07178" },
		},

		signs = {
			-- use your own highlight groups or text markers
			covered = { hl = "CoverageCovered", text = "▎" },
			uncovered = { hl = "CoverageUncovered", text = "▎" },
		},
		summary = {
			-- customize the summary pop-up
			min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
		},
		lang = {
			-- customize language specific settings
		},
	})
end

-- automatically load the coverage signs when opening a file
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.py" }, -- any file extension you're interested in
	callback = function()
		-- place (show) the signs immediately after loading
		require("coverage").load(true)
	end,
})

return Plugin
