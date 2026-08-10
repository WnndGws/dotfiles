-------------------
--- Leader Keys ---
-------------------
vim.g.mapleader = ","
local keymap = vim.keymap

-- remap change to always go to blackhole
keymap.set("n", "c", '"_c', { desc = "Always send 'Change' to blackhole register" })

-------------------
--- General Keys ---
-------------------
-- resize splits
keymap.set("n", "H", ":vertical resize +5<CR>", { desc = "Resize vertical splits LARGER" })
keymap.set("n", "L", ":vertical resize -5<CR>", { desc = "Resize vertical splits SMALLER" })

-- help for resize
keymap.set("n", "<leader>?H", ":vertical resize +5<CR>", { desc = "Resize vertical splits LARGER" })
keymap.set("n", "<leader>?L", ":vertical resize -5<CR>", { desc = "Resize vertical splits SMALLER" })

-- Save and commit
keymap.set("n", "<leader>ww", function()
	vim.cmd("write")
	vim.cmd('Git commit -m "try:autosave"')
end, { desc = "Write and add a file" })
keymap.set("n", "<leader>we", function()
	vim.cmd("write")
	vim.cmd("Git commit")
end, { desc = "Write and add a file with manual commit msg" })
keymap.set("n", "<leader>wq", function()
	vim.cmd("write")
	vim.cmd("AerialCloseAll")
	vim.cmd("NvimTreeClose")
	vim.cmd("quit")
end, { desc = "Write and add a file then quit" })
keymap.set("n", "<leader>qq", function()
	vim.cmd("AerialCloseAll")
	vim.cmd("NvimTreeClose")
	vim.cmd("quit!")
end, { desc = "Just quit. No writing" })
keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Git commands" })
keymap.set("n", "<leader>wc", ":write<CR>", { desc = "Write without commiting a file" })

-----------------------
--- Plugin Specific ---
-----------------------
--- MOVED TO EACH PLUGIN FILE
-- Tree --
--- File explorer
keymap.set({ "n" }, "<leader>e", function()
	local nvimTree = require("nvim-tree.api")
	local currentBuf = vim.api.nvim_get_current_buf()
	local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
	if currentBufFt == "NvimTree" then
		nvimTree.tree.toggle()
	else
		nvimTree.tree.focus()
	end
end, { desc = "Toggle Nvim-Tree" })

-- UFO --
vim.keymap.set("n", "<leader>zo", require("ufo").openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "<leader>zc", require("ufo").closeAllFolds, { desc = "Close all folds" })
