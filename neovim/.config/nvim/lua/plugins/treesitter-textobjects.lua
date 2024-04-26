return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					keymaps = {
						["l="] = { query = "@assignment.lhs", desc = "Change left hand side of =" },
						["r="] = { query = "@assignment.rhs", desc = "Change right hand side of =" },
						["p"] = { query = "@parameter.inner", desc = "Change right hand side of =" },
					},
				},
			},
		})
	end,
}
