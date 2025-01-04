local Plugin = { "Rawnly/gist.nvim" }

Plugin.dependencies = {
	-- Sources
	{ "samjwill/nvim-unception", init = function() vim.g.unception_block_while_host_edits = true end },
}

Plugin.event = "VeryLazy"
Plugin.cmd = { "GistCreate", "GistCreateFromFile", "GistsList" }
Plugin.keys = {
	{ "<leader>gg", "<cmd>GistCreateFromFile<cr>", desc = "Create a Gist" },
	{ "<leader>gl", "<cmd>GistsList<cr>", desc = "List all Gists" },
}

return Plugin
