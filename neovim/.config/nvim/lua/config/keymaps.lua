-------------------
--- Leader Keys ---
-------------------
vim.g.mapleader = ","
local keymap = vim.keymap

-------------------
--- General Keys ---
-------------------
---resize splits
keymap.set("n", "H", ":vertical resize +5<CR>", { desc = "Resize vertical splits LARGER" })
keymap.set("n", "L", ":vertical resize -5<CR>", { desc = "Resize vertical splits SMALLER" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Save and commit
keymap.set("n", "<leader>ww", ":write | Git add . | Git commit<CR>", { desc = "Write and commit a file" })
keymap.set("n", "<leader>wc", ":write", { desc = "Write and commit a file" })

----------------------
--- Plugin Specific---
----------------------
-- Aerial
--- Jump between buffers
--- Leader + "aerial" + "next/previous"
keymap.set("n", "<leader>at", "<cmd>AerialToggle left<CR>", { desc = "Toggle aerial", buffer = bufnr })
keymap.set("n", "<leader>an", "<cmd>AerialPrev<CR>", { desc = "Go to next function using aerial", buffer = bufnr })
keymap.set("n", "<leader>ap", "<cmd>AerialPrev<CR>", { desc = "Go to previous function using aerial", buffer = bufnr })

-- Dial
--- Better incriment and decriment
--- Leader + "increase/decrease"
-- if the below fails, try this instead
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-=", function()
	require("dial.map").manipulate("increment", "normal")
end, { desc = "Incriment using Dial" })

keymap.set("n", "<leader>--", function()
	require("dial.map").manipulate("decrement", "normal")
end, { desc = "Decriment using Dial" })

keymap.set("v", "<leader>-=", function()
	require("dial.map").manipulate("increment", "visual")
end, { desc = "Incriment using Dial" })

keymap.set("v", "<leader>--", function()
	require("dial.map").manipulate("decrement", "visual")
end, { desc = "Decriment using Dial" })

-- Marks
--- Better usage of inbuild loaction marking
--- "mark delete all"
keymap.set("n", "<leader>dam", "<cmd>delm! | delm A-Z0-9<CR>", { desc = "Clear all marks" })

-- Treesitter
--- Syntax highlighting and movements
--- NB! Set in each treesitter file

-- Tree
--- Better file exploring
keymap.set("n", "<leader>ef", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ee", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

-- Telescope
--- FZF
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

-- Gist
--- Gists from the terminal
keymap.set("n", "<leader>wg", "<cmd>GistCreateFromFile<cr>", { desc = "Saves the file as a gist" })
