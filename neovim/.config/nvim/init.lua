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
