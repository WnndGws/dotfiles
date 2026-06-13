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
	vim.cmd("Git add %")
	vim.cmd('Git commit -m "try: autosave"')
end, { desc = "Write and add a file" })
keymap.set("n", "<leader>we", function()
	vim.cmd("write")
	vim.cmd("Git add %")
	vim.cmd("Git commit")
end, { desc = "Write and add a file with manual commit msg" })
keymap.set("n", "<leader>wq", function()
	vim.cmd("write")
	vim.cmd("AerialCloseAll")
	vim.cmd("NvimTreeClose")
	vim.cmd("Git add %")
	vim.cmd("quit")
end, { desc = "Write and add a file then quit" })
keymap.set("n", "<leader>qq", function()
	vim.cmd("AerialCloseAll")
	vim.cmd("NvimTreeClose")
	vim.cmd("quit!")
end, { desc = "Just quit. No writing" })
keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Git commands" })
keymap.set("n", "<leader>wc", ":write<CR>", { desc = "Write without commiting a file" })

-- Default to Timemachine
keymap.set("n", "<leader>u", ":TimeMachineToggle", { desc = "Toggle Timemachine" })

-----------------------
--- Plugin Specific ---
-----------------------
-- Aerial --
--- Code overview window
keymap.set("n", "<leader>aa", ":AerialToggle<CR>", { desc = "Toggle Aerial open or closed" })

-- Dial --
--- Better incriment and decriment -
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

-- Expand --
--- Expand visual blocks using multiple presses of the v key
keymap.set("v", "v", "<Plug>(expand_region_expand)", { desc = "Expand selection" })
keymap.set("v", "<leader>?v", "<Plug>(expand_region_expand)", { desc = "Expand selection" })

-- Freeze --
--- Screenshot code
keymap.set({ "n", "v" }, "<leader>fa", ":Freeze<cr>", { desc = "Freeze all" })
keymap.set({ "n", "v" }, "<leader>fl", ":FreezeLine<cr>", { desc = "Freeze Line" })

-- In and Out --
--- Quickly leave surrounding characters
keymap.set({ "i", "n" }, "<C-Space>", function()
	require("in-and-out").in_and_out()
end, { desc = "Jump in and out of pairs" })

-- Markdown --
keymap.set({ "n" }, "<leader>mt", ":TOC<cr>", { desc = "Create a TOC" })
keymap.set({ "n" }, "<leader>mpo", ":PeekOpen<cr>", { desc = "Open a web browser preview of the file" })
keymap.set({ "n" }, "<leader>mpc", ":PeekClose<cr>", { desc = "Close Peek" })

-- MdTOC--
keymap.set("n", "<leader>tt", function()
	require("nvim-toc").generate_md_toc("list")
end, { desc = "Insert a TOC" })

-- Neogen --
keymap.set("n", "<leader>ng", ":Neogen<CR>", { desc = "Create Neogen for item under cursor" })

-- SnipRun --
keymap.set({ "v", "n" }, "<leader>rr", "<Plug>SnipRun", { desc = "Run selected code", silent = true })
keymap.set({ "v", "n" }, "<leader>rs", "<Plug>SnipReset", { desc = "Stop running code", silent = true })
keymap.set({ "v", "n" }, "<leader>rc", "<Plug>SnipClose", { desc = "Close virtual text", silent = true })
keymap.set(
	{ "v", "n" },
	"<leader>ri",
	"<Plug>SnipInfo",
	{ desc = "Learn about Language and Interpreter", silent = true }
)

-- Surround --
keymap.set("n", "<leader>ss", "<Plug>(nvim-surround-insert)", {
	desc = "Add a surrounding pair around the cursor",
})
keymap.set("n", "<leader>sS", "<Plug>(nvim-surround-insert-line)", {
	desc = "Add a surrounding pair around the cursor, on new lines",
})
keymap.set("n", "<leader>si", "<Plug>(nvim-surround-normal)", {
	desc = "Add a surrounding pair around a motion",
})
keymap.set("n", "<leader>sI", "<Plug>(nvim-surround-normal-line)", {
	desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
})
keymap.set("x", "<leader>ss", "<Plug>(nvim-surround-visual)", {
	desc = "Add a surrounding pair around a visual selection",
})
keymap.set("x", "<leader>sS", "<Plug>(nvim-surround-visual-line)", {
	desc = "Add a surrounding pair around a visual selection, on new lines",
})
keymap.set("n", "<leader>sd", "<Plug>(nvim-surround-delete)", {
	desc = "Delete a surrounding pair",
})
keymap.set("n", "<leader>sc", "<Plug>(nvim-surround-change)", {
	desc = "Change a surrounding pair",
})
keymap.set("n", "<leader>sC", "<Plug>(nvim-surround-change-line)", {
	desc = "Change a surrounding pair, putting replacements on new lines",
})

-- Telescope --
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
keymap.set({ "n", "v", "x" }, "<leader>tb", "<cmd>TextCaseOpenTelescope<cr>", { desc = "Change Cases" })
--- Submap for git stuff
keymap.set({ "n" }, "<leader>gc", "<cmd>Telescope git_bcommits<cr>", { desc = "Git commit history" })
keymap.set({ "n" }, "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
keymap.set({ "n" }, "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })

-- Textcase --
--- Quickly swap between text cases
keymap.set("n", "<leader>cu", function()
	require("textcase").operator("to_upper_case")
end, { desc = "TO UPPER CASE" })
keymap.set("n", "<leader>cl", function()
	require("textcase").operator("to_lower_case")
end, { desc = "to lower case" })
keymap.set("n", "<leader>cs", function()
	require("textcase").operator("to_snake_case")
end, { desc = "to_snake_case" })
keymap.set("n", "<leader>c-", function()
	require("textcase").operator("to_dash_case")
end, { desc = "to-dash-case" })
keymap.set("n", "<leader>cC", function()
	require("textcase").operator("to_constant_case")
end, { desc = "TO_CONSTANT_CASE" })
keymap.set("n", "<leader>c.", function()
	require("textcase").operator("to_dot_case")
end, { desc = "to.dot.case" })
keymap.set("n", "<leader>c,", function()
	require("textcase").operator("to_comma_case")
end, { desc = "to,comma,case" })
keymap.set("n", "<leader>cP", function()
	require("textcase").operator("to_phrase_case")
end, { desc = "To phrase case" })
keymap.set("n", "<leader>cc", function()
	require("textcase").operator("to_camel_case")
end, { desc = "toCamelCase" })
keymap.set("n", "<leader>cp", function()
	require("textcase").operator("to_pascal_case")
end, { desc = "ToPascalCase" })
keymap.set("n", "<leader>ct", function()
	require("textcase").operator("to_title_case")
end, { desc = "To Title Case" })
keymap.set("n", "<leader>c/", function()
	require("textcase").operator("to_path_case")
end, { desc = "to/path/case" })

-- Timemachine --
keymap.set({ "n" }, "<leader>u", "<cmd>TimeMachineToggle<cr>", { desc = "TimeMachineToggle" })

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
