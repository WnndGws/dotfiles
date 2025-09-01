return {
	"OXY2DEV/markview.nvim",
	lazy = false,

	config = {
		yaml = {
			properties = {
				["^title$"] = {
					use_types = false,
					text = "󰗴 ",
					hl = "MarkviewIcon0",
				},
				["^author$"] = {
					use_types = false,
					text = " ",
					hl = "MarkviewIcon0",
				},
				["^date$"] = {
					use_types = false,
					text = "󰃭 ",
					hl = "MarkviewIcon0",
				},
				["^public$"] = {
					use_types = false,
					text = "󰅧 ",
					hl = "MarkviewIcon0",
				},
			},
		},
	},
}
