return {
	"chrisgrieser/nvim-tinygit",

	ft = { "git_rebase", "gitcommit" }, -- so ftplugins are loaded
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-telescope/telescope.nvim", -- either telescope or fzf-lua
		-- "ibhagwan/fzf-lua",
	},
}
