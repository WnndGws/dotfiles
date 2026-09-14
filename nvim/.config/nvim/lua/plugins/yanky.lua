return {
	"gbprod/yanky.nvim",
	dependencies = {
		"folke/which-key.nvim",
		"folke/snacks.nvim",
	},
	enabled = true,
	lazy = false,
	priority = 1000,

	keys = {
		{
			mode = { "n", "x" },
			"<leader>sp",
			function()
				Snacks.picker.yanky()
			end,
			desc = "Open Yank History",
		},
		{
			mode = { "n", "x" },
			"<leader>pp",
			"<Plug>(YankyPutAfter)",
			desc = "Paste after cursor",
		},
		{
			mode = { "n", "x" },
			"<leader>pP",
			"<Plug>(YankyPutBefore)",
			desc = "Paste before cursor",
		},
		{
			mode = { "n", "x" },
			"p",
			"<Plug>(YankyPutIndentAfterLinewise)",
			desc = "Paste on the line below",
		},
		{
			mode = { "n", "x" },
			"P",
			"<Plug>(YankyPutIndentBeforeLinewise)",
			desc = "Paste on the line above",
		},
		{
			mode = { "n", "x" },
			"<leader>pa",
			"<Plug>(YankyPutIndentAfterLinewise)",
			desc = "Paste on the line below",
		},
		{
			mode = { "n", "x" },
			"<leader>pB",
			"<Plug>(YankyPutIndentBeforeLinewise)",
			desc = "Paste on the line above",
		},
	},

	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>p", group = "Yanky Paste", icon = "" },
		})

		local yanky = require("yanky")
		yanky.setup({
			ring = { storage = "shada" },
			system_clipboard = {
				sync_with_ring = true,
				clipboard_register = nil,
			},
			highlight = {
				on_put = true,
				on_yank = true,
				timer = 500,
			},
			preserve_cursor_position = {
				enabled = false,
			},
			picker = {
				select = {
					action = require("yanky.picker").actions.put("p"),
				},
			},
		})
	end,
}
