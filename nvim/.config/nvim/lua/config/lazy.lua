-- Taken from https://github.com/LazyVim/starter/blob/main/lua/config/lazy.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	defaults = {
		-- Load everything at startup
		lazy = false,
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = false },
	change_detection = {
		enabled = false,
	},
	rocks = { enabled = false },
	rtp = {
		paths = {},
		disabled_plugins = {
			-- "gzip",
			-- "matchit",
			-- "matchparen",
			-- "netrwPlugin",
			-- "tarPlugin",
			-- "tohtml",
			-- "tutor",
			-- "zipPlugin",
		},
	},
})
