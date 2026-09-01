return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"folke/which-key.nvim",
		"nvim-mini/mini.icons",
	},
	enabled = true,
	lazy = false,

	keys = {
		{
			mode = { "n" },
			"<leader>e",
			function()
				local nvimTree = require("nvim-tree.api")
				local currentBuf = vim.api.nvim_get_current_buf()
				local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
				if currentBufFt == "NvimTree" then
					nvimTree.tree.toggle()
				else
					nvimTree.tree.focus()
				end
			end,
			desc = "Toggle Nvim-Tree",
		},
	},

	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 35,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = ">", -- arrow when folder is closed
							arrow_open = "v", -- arrow when folder is open
						},
						git = {
							unstaged = "!",
							staged = "",
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})
	end,
}
