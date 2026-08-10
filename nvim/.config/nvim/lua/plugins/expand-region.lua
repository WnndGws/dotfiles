return {
	enabled = true,
	"terryma/vim-expand-region",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	keys = {
		{
			mode = { "v" },
			"v",
			"<Plug>(expand_region_expand)",
			desc = "Expand selection",
		},
		{
			mode = { "v" },
			"<leader>?v",
			"<Plug>(expand_region_expand)",
			desc = "Expand selection",
		},
	},
}
