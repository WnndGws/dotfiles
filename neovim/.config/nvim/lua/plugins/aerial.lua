local Plugin = { "stevearc/aerial.nvim" }

Plugin.event = "VeryLazy"
Plugin.opts = function()
	local opts = {
		attach_mode = "global",
		backends = { "lsp", "treesitter", "markdown", "man" },
		show_guides = true,
		layout = {

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
