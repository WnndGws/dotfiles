-- ~/nvim/lua/lazy.lua

vim.g.mapleader = ","

local lazy = {}

-- Install Lazy if it doesn’t exist
function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print("Installing lazy.nvim....")
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			path,
		})
	end
end

-- Load plugins
function lazy.setup(plugins)
	if vim.g.plugins_ready then
		return
	end

	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)

	require("lazy").setup(plugins, { change_detection = { notify = false } })
	vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- Creates and sets ~/.local/nvim/lazy/lazy.nvim
lazy.opts = {}

lazy.setup({ { import = "plugins" } })
