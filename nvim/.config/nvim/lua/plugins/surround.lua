local Plugin = { "kylechui/nvim-surround" }

Plugin.event = { "BufReadPost", "BufNewFile", "BufWritePre" }

Plugin.config = function()
	require("nvim-surround").setup({
		keymaps = {
			-- Add around cursor
			insert = "<leader>rs",
			-- Add around cursor but on new lines
			insert_line = "<leader>rS",
			-- Insert via movements
			normal = "<leader>ri",
			-- Insert ignoring whitespace
			normal_cur = "<leader>ra",
			-- Insert via movements but newline
			normal_line = "<leader>rI",
			-- Insert via movements, ignore whitespace, but on new line
			normal_cur_line = "<leader>rA",
			-- Add around visual
			visual = "<leader>rv",
			-- Add around visual newline
			visual_line = "<leader>rV",
			delete = "<leader>rd",
			change = "<leader>rc",
			change_line = "<leader>rC",
		},
	})
end

return Plugin
