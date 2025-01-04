local Plugin = { "Rawnly/gist.nvim" }

Plugin.event = "VeryLazy"
Plugin.cmd = { "GistCreate", "GistCreateFromFile", "GistsList" }
Plugin.keys = {
	{ "<leader>gg", "<cmd>GistCreateFromFile<cr>", desc = "Create a Gist" },
	{ "<leader>gl", "<cmd>GistsList<cr>", desc = "List all Gists" },
}

return Plugin
