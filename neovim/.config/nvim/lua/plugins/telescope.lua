return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-bibtex.nvim",
        "gbirke/telescope-foldmarkers.nvim",
        "smilovanovic/telescope-search-dir-picker.nvim",
        "tsakirist/telescope-lazy.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
        local bibtex_actions = require('telescope-bibtex.actions')
        local textcase = require('textcase').setup({})

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
            extensions = {
                bibtex = {
                    -- Depth for the *.bib file
                    depth = 1,
                    -- Custom format for citation label
                    custom_formats = {},
                    -- Format to use for citation label.
                    -- Try to match the filetype by default, or use 'plain'
                    format = '',
                    -- Path to global bibliographies (placed outside of the project)
                    global_files = {"/home/wynand/git/wiki-mdbook/src/references.bib"},
                    -- Define the search keys to use in the picker
                    search_keys = { 'author', 'year', 'title' },
                    -- Template for the formatted citation
                    citation_format = '{{author}} ({{year}}), {{title}}.',
                    -- Only use initials for the authors first name
                    citation_trim_firstname = true,
                    -- Max number of authors to write in the formatted citation
                    -- following authors will be replaced by "et al."
                    citation_max_auth = 2,
                    -- Context awareness disabled by default
                    context = false,
                    -- Fallback to global/directory .bib files if context not found
                    -- This setting has no effect if context = false
                    context_fallback = true,
                    -- Wrapping in the preview window is disabled by default
                    wrap = false,
                    -- user defined mappings
                    mappings = {
                        i = {
                            -- ["<CR>"] = bibtex_actions.key_append('%s'), -- format is determined by filetype if the user has not set it explictly
                            -- ["<C-e>"] = bibtex_actions.entry_append,
                            -- ["<C-c>"] = bibtex_actions.citation_append('{{author}} ({{year}}), {{title}}.'),
                        ["<CR>"] = bibtex_actions.key_append('(@@%s)'), -- IEEE format for webpage
                        }
                    },
                },
            }
		})
		telescope.load_extension("fzf")
		telescope.load_extension("bibtex")
		telescope.load_extension("textcase")
		telescope.load_extension("foldmarkers")
		telescope.load_extension("search_dir_picker")
		telescope.load_extension("lazy")
	end,
}
