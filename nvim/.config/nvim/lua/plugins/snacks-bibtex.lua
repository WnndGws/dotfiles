-- full opts, defined once and reused for both lazy.nvim setup and keymaps
local opts = {
	global_files = { "~/git/git-wiki/references.bib" },
	default_insert_mode = "format",
	citation_formats = {
		{
			id = "vancouver_in_text",
			name = "Vancouver (in-text, numbered)",
			template = "[^0]",
			description = "Vancouver in-text citation; edit the number manually",
			category = "in_text",
			locale = "en",
			enabled = true,
		},
		{
			id = "vancouver_reference",
			name = "Vancouver (reference list)",
			-- template = "{{authors.reference}}. {{title}}. {{journal}}. {{year}};" .. "{{volume}}({{issue}}):{{pages}}.",
			template = "[0]: {{title}}, Cited {{urldate}}, Available from [Link]({{url}})",
			category = "reference",
			locale = "en",
			enabled = true,
		},
	},
}

-- setup() merges opts over the DEFAULTS, not over the current config,
-- so each call must carry the full table, with mappings added on top
local function pick(mapping_overrides)
	require("snacks-bibtex").setup(vim.tbl_deep_extend("force", opts, { mappings = mapping_overrides }))
	require("snacks-bibtex").bibtex()
end

return {
	"krissen/snacks-bibtex.nvim",
	dependencies = { "folke/snacks.nvim", "folke/which-key.nvim" },
	opts = opts,
	lazy = true,
	keys = {
		{
			"<leader>bv",
			function()
				pick({
					-- custom action: append at end of line instead of at cursor
					["<cr>"] = function(picker, item)
						if not item then
							return
						end
						picker:close({ status = true })
						vim.schedule(function()
							local row = vim.api.nvim_win_get_cursor(0)[1]
							local line = vim.api.nvim_get_current_line()
							local pad = (line ~= "" and not line:match("%s$")) and " " or ""
							vim.fn.setline(row, line .. pad .. "[^0]")
							-- park cursor after the inserted text
							vim.api.nvim_win_set_cursor(0, { row, #vim.api.nvim_get_current_line() })
						end)
					end,
					["<C-cr>"] = { kind = "citation_format", id = "vancouver_reference" },
				})
			end,
			desc = "BibTeX citations (Vancouver)",
		},
		{
			"<leader>bh",
			function()
				pick({
					["<cr>"] = { kind = "citation_format", id = "harvard_in_text" },
					["<C-cr>"] = { kind = "citation_format", id = "harvard_reference" },
				})
			end,
			desc = "BibTeX citations (Harvard)",
		},
	},
}
