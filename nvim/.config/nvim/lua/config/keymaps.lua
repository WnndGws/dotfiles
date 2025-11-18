-------------------
--- Leader Keys ---
-------------------
vim.g.mapleader = ","
local keymap = vim.keymap

-------------------
--- General Keys ---
-------------------
-- resize splits
keymap.set("n", "H", ":vertical resize +5<CR>", { desc = "Resize vertical splits LARGER" })
keymap.set("n", "L", ":vertical resize -5<CR>", { desc = "Resize vertical splits SMALLER" })
-- help for resize
keymap.set("n", "<leader>?H", ":vertical resize +5<CR>", { desc = "Resize vertical splits LARGER" })
keymap.set("n", "<leader>?L", ":vertical resize -5<CR>", { desc = "Resize vertical splits SMALLER" })

--move between windows
keymap.set({ "n", "i" }, "<C-h>", ":wincmd h<cr>", { desc = "Move to left split" })
keymap.set({ "n", "i" }, "<C-j>", ":wincmd j<cr>", { desc = "Move to bottom split" })
keymap.set({ "n", "i" }, "<C-k>", ":wincmd k<cr>", { desc = "Move to top split" })
keymap.set({ "n", "i" }, "<C-l>", ":wincmd l<cr>", { desc = "Move to right split" })

-- help for move between windows
keymap.set({ "n", "i" }, "<leader>?<C-h>", ":wincmd h<cr>", { desc = "Move to left split" })
keymap.set({ "n", "i" }, "<leader>?<C-j>", ":wincmd j<cr>", { desc = "Move to bottom split" })
keymap.set({ "n", "i" }, "<leader>?<C-k>", ":wincmd k<cr>", { desc = "Move to top split" })
keymap.set({ "n", "i" }, "<leader>?<C-l>", ":wincmd l<cr>", { desc = "Move to right split" })

-- Save and commit
keymap.set("n", "<leader>ww", ":write | Git add . | Git commit<CR>", { desc = "Write and commit a file" })
keymap.set("n", "<leader>wc", ":write<CR>", { desc = "Write without commiting a file" })

-----------------------
--- Plugin Specific ---
-----------------------
----------
-- Dial --
----------
--- Better incriment and decriment
keymap.set("n", "+", function()
	require("dial.map").manipulate("increment", "normal")
end, { desc = "Incriment using Dial" })
keymap.set("n", "<leader>?+", function()
	require("dial.map").manipulate("increment", "normal")
end, { desc = "Incriment using Dial" })

keymap.set("n", "_", function()
	require("dial.map").manipulate("decrement", "normal")
end, { desc = "Decriment using Dial" })
keymap.set("n", "<leader>?_", function()
	require("dial.map").manipulate("decrement", "normal")
end, { desc = "Decriment using Dial" })

keymap.set("n", "<C-a>", function()
	require("dial.map").manipulate("increment", "normal")
end, { desc = "Incriment using Dial" })

keymap.set("n", "<C-s>", function()
	require("dial.map").manipulate("decrement", "normal")
end, { desc = "Decriment using Dial" })

keymap.set("n", "<leader>=", function()
	require("dial.map").manipulate("increment", "normal")
end, { desc = "Incriment using Dial" })

keymap.set("n", "<leader>-", function()
	require("dial.map").manipulate("decrement", "normal")
end, { desc = "Decriment using Dial" })

keymap.set("v", "<leader>=", function()
	require("dial.map").manipulate("increment", "visual")
end, { desc = "Incriment using Dial" })

keymap.set("v", "<leader>-", function()
	require("dial.map").manipulate("decrement", "visual")
end, { desc = "Decriment using Dial" })

------------
-- Expand --
------------
keymap.set("v", "v", "<Plug>(expand_region_expand)", { desc = "Expand selection" })
keymap.set("v", "<leader>?v", "<Plug>(expand_region_expand)", { desc = "Expand selection" })

---------
-- Hop --
---------
keymap.set("n", "<leader>hw", "<cmd>HopWord<cr>", { desc = "Hop in a word" })

----------------
-- In and Out --
----------------
keymap.set({ "i", "n" }, "<C-CR>", function()
	require("in-and-out").in_and_out()
end, { desc = "Jump in and out of pairs" })
keymap.set({ "i", "n" }, "<leader>?<C-CR>", function()
	require("in-and-out").in_and_out()
end, { desc = "Jump in and out of pairs" })

----------
-- MdTOC--
----------
keymap.set("n", "<leader>tt", function()
	require("nvim-toc").generate_md_toc("list")
end, { desc = "Insert a TOC" })

---------------------
-- Toggle Checkbox --
---------------------
-- toggle checked / create checkbox if it doesn't exist
keymap.set("n", "<leader>ct", require("markdown-togglecheck").toggle, { desc = "Toggle checked/unchecked" })
-- toggle checkbox (it doesn't remember toggle state and always creates [ ])
keymap.set("n", "<leader>cb", require("markdown-togglecheck").toggle_box, { desc = "Toggle box exists/doesnt" })

-------------
-- Outline --
-------------
keymap.set("n", "<leader>a", ":AerialToggle! right<cr>", { desc = "Toggle showing Outline" })

-------------
-- SnipRun --
-------------
keymap.set({ "v", "n" }, "<leader>sr", "<Plug>SnipRun", { desc = "Run selected code", silent = true })
keymap.set({ "v", "n" }, "<leader>ss", "<Plug>SnipReset", { desc = "Stop running code", silent = true })
keymap.set({ "v", "n" }, "<leader>sc", "<Plug>SnipClose", { desc = "Close virtual text", silent = true })
keymap.set(
	{ "v", "n" },
	"<leader>si",
	"<Plug>SnipInfo",
	{ desc = "Learn about Language and Interpreter", silent = true }
)

--------------
-- Surround --
--------------
--- Defined in config file, since not straight-forward

---------------
-- Telescope --
---------------
keymap.set({ "n" }, "<leader>t/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find IN file" })
keymap.set({ "n" }, "<leader>tc", "<cmd>Telescope commands<cr>", { desc = "All commands possible" })
keymap.set({ "n" }, "<leader>td", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
keymap.set({ "n" }, "<leader>te", "<cmd>Telescope symbols<cr>", { desc = "Emojis and symbols" })
keymap.set({ "n" }, "<leader>tf", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set({ "n" }, "<leader>th", "<cmd>Telescope command_history<cr>", { desc = "Command history" })
keymap.set({ "n" }, "<leader>th", "<cmd>Telescope heading<cr>", { desc = "Headings" })
keymap.set({ "n" }, "<leader>tl", "<cmd>Telescope highlights<cr>", { desc = "Highlighting rules" })
keymap.set({ "n" }, "<leader>to", "<cmd>Telescope vim_options<cr>", { desc = "NVim options" })
keymap.set({ "n" }, "<leader>tr", "<cmd>Telescope registers<cr>", { desc = "Registers" })
keymap.set({ "n" }, "<leader>ts", "<cmd>Telescope spell_suggest<cr>", { desc = "Spelling suggestions" })
keymap.set({ "n" }, "<leader>tu", "<cmd>Telescope undo<cr>", { desc = "Undo" })
keymap.set({ "n" }, "<leader>ty", "<cmd>Telescope yank_history<cr>", { desc = "Yank history" })

-- Submap for git stuff
keymap.set({ "n" }, "<leader>gc", "<cmd>Telescope git_bcommits<cr>", { desc = "Git commit history" })
keymap.set({ "n" }, "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
keymap.set({ "n" }, "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })

-----------------
-- Timemachine --
-----------------
keymap.set({ "n" }, "<leader>u", "<cmd>TimeMachineToggle<cr>", { desc = "TimeMachineToggle" })

----------
-- Tree --
----------
-- Use same key to toggle or hide

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

------------
-- Freeze --
------------
keymap.set({ "n", "v" }, "<leader>fa", ":Freeze<cr>", { desc = "Freeze all" })
keymap.set({ "n", "v" }, "<leader>fl", ":FreezeLine<cr>", { desc = "Freeze Line" })

--------------
-- Markdown --
--------------
keymap.set({ "n" }, "<leader>mt", ":TOC<cr>", { desc = "Create a TOC" })
keymap.set({ "n" }, "<leader>mpo", ":PeekOpen<cr>", { desc = "Open a web browser preview of the file" })
keymap.set({ "n" }, "<leader>mpc", ":PeekClose<cr>", { desc = "Close Peek" })

---------
-- UFO --
---------
vim.keymap.set("n", "<leader>zo", require("ufo").openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "<leader>zc", require("ufo").closeAllFolds, { desc = "Close all folds" })
