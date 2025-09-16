-- ~/.config/nvim/init.lua

require("config.lazy")
require("config.settings")
require("config.autocommands")
require("config.keymaps")

vim.api.nvim_create_user_command("DeleteDuplicateLine", function()
	local current_line = vim.fn.getline(".")
	local previous_line = vim.fn.getline(vim.fn.line(".") - 1)
	local delimiter = " - "
	local current_line_prefix = current_line:match("^(.*)" .. delimiter)
	local previous_line_prefix = previous_line:match("^(.*)" .. delimiter)

	if current_line_prefix == previous_line_prefix and vim.fn.line(".") > 1 then
		vim.cmd("delete")
	else
		vim.cmd("norm j0")
	end
end, {})
