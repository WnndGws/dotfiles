return {
	"OXY2DEV/markview.nvim",
	lazy = true,

	config = {
		experimental = {
			check_rtp = true,
			check_rtp_msg = false,
		},
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
