return {
	"AlejandroSuero/freeze-code.nvim",
	config = function()
		require("freeze-code").setup({
			freeze_path = vim.fn.exepath("freeze"), -- where is freeze installed
			copy_cmd = "wl-copy < filename && rm filename",
			copy = true, -- copy after screenshot option
			open = false, -- open after screenshot option
			dir = vim.env.PWD, -- where is the image going to be saved "." as default
			freeze_config = { -- configuration options for `freeze` command
				output = "freeze.svg",
				window = true,
				version = true,
				theme = "dracula",
				border = {
					radius = 20,
					width = 2,
					color = "#515151",
				},
				font = {
					family = "SourceCodePro Mono",
					file = "",
					size = 12,
					ligatures = true,
				},
				show_line_numbers = true,
			},
		})
	end,
}
