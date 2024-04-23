-------------------
--- Leader Keys ---
-------------------
vim.g.mapleader = ","
local keymap = vim.keymap

-------------------
--- General Keys ---
-------------------
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Save and commit
keymap.set("n", "<leader>ww", ":w | Neogit commit<CR>", { desc = "Save and commit" })
keymap.set("n", "ZZ", ":w | Neogit commit | :q<CR>", { desc = "Save and commit" })
keymap.set("n", "<leader>wc", ":w", { desc = "Save file" })

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

-- MarkdownPreview
--- Leader + "markdown" + "preview"
keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Preview Markdown" })

-- Marks
--- Better usage of inbuild loaction marking
--- "mark delete all"
keymap.set("n", "<leader>dam", "<cmd>delm! | delm A-Z0-9<CR>", { desc = "Clear all marks" })

-- Tree
--- Better file exploring
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
