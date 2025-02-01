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
keymap.set("n", "<leader>wc", ":write<CR>", { desc = "Write without commiting a file" })

-- Clean naked URLs
keymap.set("n", "<leader>cu", function()
    vim.cmd("norm 0f<ya<0f<r[f>r]p")
    vim.cmd("norm 0f<r(f>r)")
end, {desc = "Clean naked URLs"})

-- Custom Jira Function
keymap.set("n", "<leader>cj", function()
    vim.cmd("norm Go")
    vim.cmd("read !jira issue view %:t:r")
    vim.cmd([[%s/.*— \([a-zA-Z]\)\@=/# /g]])
    vim.cmd([[%s/—.*//g]])
    vim.cmd([[%s/# /### /g]])
    vim.cmd([[%s/---\n\n/---\r\r## Jira/g]])
    vim.cmd("nohl")
end, {desc = "Insert Jira ticket matching file name"})

-- Custom slackdump
--- Define a function to insert shell command output into the buffer
function InsertURLShellOutput()
    -- Prompt the user for a URL
    local url = vim.fn.input('Enter URL: ')
    -- If the user cancels the input or leaves it empty, do nothing
    if url == nil or url == '' then
        return
    end
    -- Escape the URL to prevent shell injection
    local escaped_url = vim.fn.shellescape(url)
    -- Construct the shell command
    local command = '/home/wynand/git/personal/wiki-docusaurus/create_slack.sh ' .. escaped_url
    -- Read the output of the command into the buffer at the current cursor position
    vim.cmd('r !' .. command)
end
keymap.set("n", "<leader>cs", [[:lua InsertURLShellOutput()<CR>]], { desc = "Insert link to slackdump conversation", noremap=true, silent=true })

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
keymap.set("n", "<C-a>", function()
	require("dial.map").manipulate("increment", "normal")
end, { desc = "Incriment using Dial" })

keymap.set("n", "<C-s>", function()
	require("dial.map").manipulate("decrement", "normal")
end, { desc = "Decriment using Dial" })

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
keymap.set("n", "<leader>md", "<cmd>delm! | delm A-Z0-9<CR>", { desc = "Clear all marks" })

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
-- Templates
keymap.set("n", "<leader>b", "<cmd>Telescope find_template type=insert filter_ft=false<cr>", { desc = "Insert a template" })
--- FZF
keymap.set("n", "<leader>ff", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope search_dir_picker<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fs", "<cmd>Telescope symbols<cr>", { desc = "Find and insert a symbol" })
--- List
keymap.set("n", "<leader>lc", "<cmd>Telescope commands<cr>", { desc = "Lists available plugin/user commands and runs them" })
keymap.set("n", "<leader>lm", "<cmd>Telescope marks<cr>", { desc = "Lists vim marks and their value" })
keymap.set("n", "<leader>lf", "<cmd>Telescope treesitter<cr>", { desc = "Lists Function names, variables, from Treesitter" })
--- Spelling
keymap.set("n", "<leader>sc", "<cmd>Telescope spell_suggest<cr>", { desc = "Lists spelling suggestions for the current word under the cursor" })
--- Generic Telescope
keymap.set("n", "<leader>tc", "<cmd>TextCaseOpenTelescopeQuickChange<cr>", { desc = "Change the case of the word under the cursor" })
keymap.set("n", "<leader>tr", "<cmd>Telescope bibtex<cr>", { desc = "Select and insert a bibtex reference" })
keymap.set("i", "@@", "<c-o><cmd>Telescope bibtex<cr>", { desc = "Select and insert a bibtex reference" })
keymap.set("n", "<leader>tf", "<cmd>Telescope foldmarkers<cr>", { desc = "Select vim folds" })
keymap.set("n", "<leader>tl", "<cmd>Telescope lazy<cr>", { desc = "Use Telescope with Lazy" })

-- Gist
--- Gists from the terminal
keymap.set("n", "<leader>wg", "<cmd>GistCreateFromFile<cr>", { desc = "Saves the file as a gist" })

-- FoldCycle
--- Shortcuts for folding
keymap.set('n', 'zo',
  function() return require('fold-cycle').open_all() end,
  {silent = true, desc = 'Fold-cycle: open folds'})
keymap.set('n', 'zO',
  function() return require('fold-cycle').open() end,
  {silent = true, desc = 'Fold-cycle: open folds'})
keymap.set('n', 'zC',
  function() return require('fold-cycle').close() end,
  {silent = true, desc = 'Fold-cycle: close folds'})
keymap.set('n', 'zc',
  function() return require('fold-cycle').close_all() end,
  {remap = true, silent = true, desc = 'Fold-cycle: close all folds'})

-- Python DAP
keymap.set('n', '<leader>db',
  function() return require('dap').toggle_breakpoint() end,
  {remap = true, silent = true, desc = 'DAP: Toggle Breakpoints'})

keymap.set('n', '<leader>dc',
  function() return require('dap').continue() end,
  {remap = true, silent = true, desc = 'DAP: Continue'})

keymap.set('n', '<leader>dsv',
  function() return require('dap').step_over() end,
  {remap = true, silent = true, desc = 'DAP: Step Over'})

keymap.set('n', '<leader>dsi',
  function() return require('dap').step_in() end,
  {remap = true, silent = true, desc = 'DAP: Step In'})

keymap.set('n', '<leader>dso',
  function() return require('dap').step_out() end,
  {remap = true, silent = true, desc = 'DAP: Step Out'})

keymap.set('n', '<leader>dq',
  function() return require('dap').terminate() end,
  {remap = true, silent = true, desc = 'DAP: Quit'})

keymap.set('n', '<leader>du',
  function() return require('dapui').toggle() end,
  {remap = true, silent = true, desc = 'DAP: Toggle UI'})
