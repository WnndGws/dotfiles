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
	vim.cmd("OutlineClose")
	vim.cmd("NvimTreeClose")
	vim.cmd("quit")
end, { desc = "Write and add a file then quit" })
keymap.set("n", "<leader>qq", function()
	vim.cmd("OutlineClose")
	vim.cmd("NvimTreeClose")
	vim.cmd("quit!")
end, { desc = "Just quit. No writing" })
keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Git commands" })
keymap.set("n", "<leader>wc", ":write<CR>", { desc = "Write without commiting a file" })

--------------------------------
--- Which-Key Driven Changes ---
--------------------------------
-- LSP help
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover LSP Documentation" })

-- Disable some inbuilts that cause me grief
vim.api.nvim_del_keymap("n", "&")
vim.api.nvim_del_keymap("n", "Y")

-- Disable matchit's % mappings
vim.api.nvim_del_keymap("n", "%")
vim.api.nvim_del_keymap("x", "%")
vim.api.nvim_del_keymap("o", "%")
