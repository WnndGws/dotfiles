;; lua
local Plugin = { "stevearc/aerial.nvim" }

Plugin.event = "VeryLazy"

Plugin.opts = function()
	local opts = {
		attach_mode = "global",
		backends = { "treesitter" },
		show_guides = true,
	}
	return opts
end

Plugin.keys = {
	{
		"<leader>p",
		function()
			require("telescope").extensions.yank_history.yank_history({})
		end,
        mode = { "n", "v"},
		desc = "Open Yank History",
	},
}

return Plugin
