return {
	"christoomey/vim-tmux-navigator",
	enabled = false,
	event = { "VeryLazy" },

	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
		"TmuxNavigatorProcessList",
	},

	keys = {
		{
			mode = { "n" },
			"<c-h>",
			":TmuxNavigateLeft<cr>",
			desc = "Tmux Navigate Left",
		},
		{
			mode = { "n" },
			"<c-j>",
			":TmuxNavigateDown<cr>",
			desc = "Tmux Navigate Down",
		},
		{
			mode = { "n" },
			"<c-k>",
			":TmuxNavigateUp<cr>",
			desc = "Tmux Navigate Up",
		},
		{
			mode = { "n" },
			"<c-l>",
			":TmuxNavigateRight<cr>",
			desc = "Tmux Navigate Right",
		},
		{
			mode = { "n" },
			"<c-\\>",
			":TmuxNavigatePrevious<cr>",
			desc = "Tmux Navigate Previous",
		},
	},
}
