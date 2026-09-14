return {
	"yorickpeterse/nvim-tree-pairs",
	dependencies = { "nvim-treesitter" },

	enabled = true,

	config = function()
		require("tree-pairs").setup()

		-- Mirror the plugin's buffer-local "%" mapping onto "}"
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("tree-pairs-brace", { clear = true }),
			pattern = "*",
			callback = function()
				local buf = vim.api.nvim_get_current_buf()

				-- Skip the same filetypes the plugin skips
				if vim.bo[buf].ft == "netrw" then
					return
				end

				for _, mode in ipairs({ "n", "x", "o" }) do
					vim.keymap.set(mode, "{", "%", {
						remap = true, -- follow the plugin's buffer-local "%" mapping
						buffer = true,
						desc = "tree-pairs: jump to opposite end of node",
					})
					vim.keymap.set(mode, "}", "%", {
						remap = true, -- follow the plugin's buffer-local "%" mapping
						buffer = true,
						desc = "tree-pairs: jump to opposite end of node",
					})
				end
			end,
		})
	end,
}
