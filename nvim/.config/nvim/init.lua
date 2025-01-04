----------------
--- LAZY VIM ---
----------------
vim.g.mapleader = ","

local load = function(mod)
	package.loaded[mod] = nil
	require(mod)
end

require("config.lazy")
load("config.keymaps")
load("config.nvim_settings")
