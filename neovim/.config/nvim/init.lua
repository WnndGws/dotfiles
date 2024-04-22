-------------------
--- Leader Keys ---
-------------------
vim.g.mapleader = ","

----------------
--- LAZY VIM ---
----------------
local load = function(mod)
	package.loaded[mod] = nil
	require(mod)
end

require("config.lazy")
load("config.keymaps")
load("config.nvim_settings")

-------------
--- Theme ---
-------------
-- provided by ../plugins/theme.lua
vim.cmd.colorscheme("tokyonight")
