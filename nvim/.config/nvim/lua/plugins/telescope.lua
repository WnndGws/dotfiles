local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope-bibtex.nvim",
	"nvim-telescope/telescope-symbols.nvim",
	"crispgm/telescope-heading.nvim",
	"debugloop/telescope-undo.nvim",
	"catgoose/telescope-helpgrep.nvim",
	"mrloop/telescope-git-branch.nvim",
}

Plugin.config = function()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")

	telescope.setup({
		defaults = {
			path_display = { "smart" },
		},
		extensions = {
			undo = {
				use_delta = true,
			},
			helpgrep = {
				ignore_paths = {
					vim.fn.stdpath("state") .. "/lazy/readme",
				},
				default_grep = builtin.live_grep,
			},
		},
		telescope.load_extension("heading"),
		telescope.load_extension("yank_history"),
		telescope.load_extension("undo"),
		telescope.load_extension("helpgrep"),
		telescope.load_extension("git_branch"),
		telescope.load_extension("textcase"),
	})
end

return Plugin
