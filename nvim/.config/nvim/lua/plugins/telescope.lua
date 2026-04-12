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
	local bibtex_actions = require("telescope-bibtex.actions")

	telescope.setup({
		defaults = {
			path_display = { "smart" },
		},
		extensions = {
			bibtex = {
				global_files = { "/home/wynand/git/git-wiki/references.bib" },
				search_keys = { "author", "year", "title" },
				citation_format = "{{author}} ({{year}}), {{title}}.",
				citation_trim_firstname = true,
				context = true,
				context_fallback = true,
				mappings = {
					i = {
						["<CR>"] = bibtex_actions.key_append("%s"), -- format is determined by filetype if the user has not set it explictly
						["<C-u>"] = bibtex_actions.citation_append(
							"{{author}}. {{title}}. {{url}}. Accessed {{urldate}}"
						),
					},
				},
			},
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
		telescope.load_extension("bibtex"),
		telescope.load_extension("heading"),
		telescope.load_extension("yank_history"),
		telescope.load_extension("undo"),
		telescope.load_extension("helpgrep"),
		telescope.load_extension("git_branch"),
		telescope.load_extension("textcase"),
	})
end

return Plugin
