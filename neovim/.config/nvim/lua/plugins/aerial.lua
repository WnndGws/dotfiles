local Plugin = { "stevearc/aerial.nvim" }

Plugin.event = "VeryLazy"
Plugin.opts = function()
	local opts = {
		attach_mode = "global",
		backends = { "treesitter"},
		show_guides = true,
		layout = {
            -- These control the width of the aerial window.
            -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_width and max_width can be a list of mixed types.
            -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
            max_width = { 40, 0.2 },
            width = nil,
            min_width = { 40, 0.2 },
			resize_to_content = false,
			win_opts = {

				winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
				signcolumn = "yes",
				statuscolumn = " ",
			},
		},
        -- stylua: ignore
        guides = {
            mid_item   = "├╴",
            last_item  = "└╴",
            nested_top = "│ ",
            whitespace = "  ",
        },
	}
	return opts
end
Plugin.keys = {
	{ "<leader>at", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
}

return Plugin
