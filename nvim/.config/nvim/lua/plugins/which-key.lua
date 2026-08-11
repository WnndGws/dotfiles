return {
	"folke/which-key.nvim",
	enabled = true,
	lazy = true,
	dependencies = { "nvim-mini/mini.icons" },

	opts = {
		preset = "modern",
		triggers = {
			{ "<auto>", mode = "nixsotc" },
			{ "a", mode = { "n", "v" } },
		},
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = false,
			presets = {
				operators = false, -- adds help for operators like d, y, ...
				motions = false, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = false, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		sort = { "order" },
		expand = 1,
		replace = {
			key = {
				function(key)
					return require("which-key.view").format(key)
				end,
				-- { "<Space>", "SPC" },
			},
			desc = {
				-- { "<Plug>%(?(.*)%)?", "%1" },
				-- { "^%+", "" },
				-- { "<[cC]md>", "" },
				-- { "<[cC][rR]>", "" },
				-- { "<[sS]ilent>", "" },
				-- { "^lua%s+", "" },
				-- { "^call%s+", "" },
				-- { "^:%s*", "" },
			},
		},
		icons = {
			rules = {
				--- These are the default rules. Changes noted.
				{ pattern = "%f[%a]ai", icon = " ", color = "green" },
				{ pattern = "%f[%a]git", cat = "filetype", name = "git" },
				{ pattern = "buffer", icon = "󰈔", color = "cyan" },
				{ pattern = "code", icon = " ", color = "orange" },
				{ pattern = "debug", icon = "󰃤 ", color = "red" },
				{ pattern = "diagnostic", icon = "󱖫 ", color = "green" },
				{ pattern = "exit", icon = "󰈆 ", color = "red" },
				{ pattern = "find", icon = " ", color = "green" },
				{ pattern = "file", icon = "󰈔", color = "cyan" },
				{ pattern = "format", icon = " ", color = "cyan" },
				{ pattern = "lazy", cat = "filetype", name = "lazy" },
				{ pattern = "notif", icon = "󰵅 ", color = "blue" },
				{ pattern = "profiler", icon = "⚡", color = "orange" },
				{ pattern = "quit", icon = "󰈆 ", color = "red" },
				{ pattern = "search", icon = " ", color = "green" },
				{ pattern = "session", icon = " ", color = "azure" },
				{ pattern = "tab", icon = "󰓩 ", color = "purple" },
				{ pattern = "terminal", icon = " ", color = "red" },
				{ pattern = "test", cat = "filetype", name = "neotest-summary" },
				{ pattern = "toggle", icon = " ", color = "yellow" },
				{ pattern = "ui", icon = "󰙵 ", color = "cyan" },
				{ pattern = "window", icon = " ", color = "blue" },
				{ plugin = "CopilotChat.nvim", icon = " ", color = "orange" },
				{ plugin = "dial.nvim", icon = "󰦒", color = "yellow" }, -- Added
				{ plugin = "fzf-lua", cat = "filetype", name = "fzf" },
				{ plugin = "grapple.nvim", pattern = "grapple", icon = "󰛢", color = "azure" },
				{ plugin = "grug-far.nvim", pattern = "grug", icon = "󰛔 ", color = "blue" },
				{ plugin = "lazy.nvim", cat = "filetype", name = "lazy" },
				{ plugin = "neo-tree.nvim", cat = "filetype", name = "neo-tree" },
				{ plugin = "neotest", cat = "filetype", name = "neotest-summary" },
				{ plugin = "noice.nvim", pattern = "noice", icon = "󰈸", color = "orange" },
				{ plugin = "nvim-spectre", icon = "󰛔 ", color = "blue" },
				{ plugin = "octo.nvim", cat = "filetype", name = "git" },
				{ plugin = "persistence.nvim", icon = " ", color = "azure" },
				{ plugin = "refactoring.nvim", pattern = "refactor", icon = " ", color = "cyan" },
				-- { plugin = "snacks.nvim", icon = "", color = "purple" }, -- Changed icon
				{ plugin = "telescope.nvim", pattern = "telescope", icon = "", color = "blue" },
				{ plugin = "todo-comments.nvim", cat = "file", name = "TODO" },
				{ plugin = "trouble.nvim", cat = "filetype", name = "trouble" },
				{ plugin = "yanky.nvim", icon = "󰅇", color = "yellow" },
				{ plugin = "zen-mode.nvim", icon = "󱅻 ", color = "cyan" },
			},
		},
	},

	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			{ ",", group = "<leader> functions", icon = "󰸤", mode = { "n", "v" } },
		})
	end,
}
