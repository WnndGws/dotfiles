local Plugin = { "tpope/vim-fugitive" }

Plugin.event = "VeryLazy"
Plugin.keys = {
	{ "<leader>gs", "<cmd>Git<cr>", desc = "Git Summary" },
	{ "<leader>gw", "<cmd>Gwrite<cr>", desc = "Write current file and stage the reults" },
	{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Split and show diff" },
}

return Plugin
