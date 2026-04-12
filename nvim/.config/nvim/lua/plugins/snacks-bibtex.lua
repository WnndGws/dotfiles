return {
	"krissen/snacks-bibtex.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		global_files = { "~/git/git-wiki/references.bib" },
		default_insert_mode = "format",
		mappings = { ["<cr>"] = { kind = "citation_format", id = "apa7_reference" } },
	},
	keys = {
		{
			"<leader>bb",
			function()
				require("snacks-bibtex").bibtex()
			end,
			desc = "BibTeX citations",
		},
	},
}
