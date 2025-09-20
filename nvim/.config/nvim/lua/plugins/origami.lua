local Plugin = { "chrisgrieser/nvim-origami" }

Plugin.dependencies = {}
Plugin.lazy = false

Plugin.event = { "VeryLazy" }

-- recommended: disable vim's auto-folding
Plugin.init = function()
	vim.opt.foldlevel = 99
	vim.opt.foldlevelstart = 99
end

Plugin.opts = function()
	local origami = require("origami")
	origami.setup({
		useLspFoldsWithTreesitterFallback = true,
		pauseFoldsOnSearch = true,
		foldtext = {
			enabled = true,
			padding = 3,
			lineCount = {
				template = "%d lines", -- `%d` is replaced with the number of folded lines
				hlgroup = "Comment",
			},
			diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
			gitsignsCount = true, -- requires `gitsigns.nvim`
		},
		autoFold = {
			enabled = true,
			kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
		},
		foldKeymaps = {
			setup = true, -- modifies `h`, `l`, and `$`
			hOnlyOpensOnFirstColumn = false,
		},
		setting = { setting2 = "string" },
	})
end

return Plugin
