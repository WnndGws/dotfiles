return {
	"y3owk1n/undo-glow.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	---@type UndoGlow.Config
	opts = {
		animation = {
			enabled = true,
			duration = 300,
			animtion_type = "zoom",
			window_scoped = true,
		},
		highlights = {
			undo = {
				hl_color = { bg = "#693232" }, -- Dark muted red
			},
			redo = {
				hl_color = { bg = "#2F4640" }, -- Dark muted green
			},
			yank = {
				hl_color = { bg = "#7A683A" }, -- Dark muted yellow
			},
			paste = {
				hl_color = { bg = "#325B5B" }, -- Dark muted cyan
			},
			search = {
				hl_color = { bg = "#5C475C" }, -- Dark muted purple
			},
			comment = {
				hl_color = { bg = "#7A5A3D" }, -- Dark muted orange
			},
			cursor = {
				hl_color = { bg = "#793D54" }, -- Dark muted pink
			},
		},
		priority = 2048 * 3,
	},
	init = function()
		vim.api.nvim_create_autocmd("TextYankPost", {
			desc = "Highlight when yanking (copying) text",
			callback = function()
				require("undo-glow").yank()
			end,
		})

		-- This only handles neovim instance and do not highlight when switching panes in tmux
		vim.api.nvim_create_autocmd("CursorMoved", {
			desc = "Highlight when cursor moved significantly",
			callback = function()
				require("undo-glow").cursor_moved({
					animation = {
						animation_type = "slide",
					},
				})
			end,
		})

		-- This will handle highlights when focus gained, including switching panes in tmux
		vim.api.nvim_create_autocmd("FocusGained", {
			desc = "Highlight when focus gained",
			callback = function()
				---@type UndoGlow.CommandOpts
				local opts = {
					animation = {
						animation_type = "slide",
					},
				}

				opts = require("undo-glow.utils").merge_command_opts("UgCursor", opts)
				local pos = require("undo-glow.utils").get_current_cursor_row()

				require("undo-glow").highlight_region(vim.tbl_extend("force", opts, {
					s_row = pos.s_row,
					s_col = pos.s_col,
					e_row = pos.e_row,
					e_col = pos.e_col,
					force_edge = opts.force_edge == nil and true or opts.force_edge,
				}))
			end,
		})

		vim.api.nvim_create_autocmd("CmdLineLeave", {
			pattern = { "/", "?" },
			desc = "Highlight when search cmdline leave",
			callback = function()
				require("undo-glow").search_cmd({
					animation = {
						animation_type = "fade",
					},
				})
			end,
		})
	end,
}
