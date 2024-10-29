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
keymap.set("n", "<leader>lu", "<cmd>UrlView<cr>", { desc = "Lists Function names, variables, from Treesitter" })
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

-- GPT
--- Visual
keymap.set('v', "<leader>p<C-t>", "<cmd>GpChatNew tabnew<cr>", { desc = "ChatNew tabnew" })
keymap.set('v', "<leader>p<C-v>", "<cmd>GpChatNew vsplit<cr>", { desc = "ChatNew vsplit" })
keymap.set('v', "<leader>p<C-x>", "<cmd>GpChatNew split<cr>", { desc = "ChatNew split" })
keymap.set('v', "<leader>pa", "<cmd>GpAppend<cr>", { desc = "Visual Append (after)" })
keymap.set('v', "<leader>pb", "<cmd>GpPrepend<cr>", { desc = "Visual Prepend (before)" })
keymap.set('v', "<leader>pc", "<cmd>GpChatNew<cr>", { desc = "Visual Chat New" })
keymap.set('v', "<leader>pge", "<cmd>GpEnew<cr>", { desc = "Visual GpEnew" })
keymap.set('v', "<leader>pgn", "<cmd>GpNew<cr>", { desc = "Visual GpNew" })
keymap.set('v', "<leader>pgp", "<cmd>GpPopup<cr>", { desc = "Visual Popup" })
keymap.set('v', "<leader>pgt", "<cmd>GpTabnew<cr>", { desc = "Visual GpTabnew" })
keymap.set('v', "<leader>pgv", "<cmd>GpVnew<cr>", { desc = "Visual GpVnew" })
keymap.set('v', "<leader>pi", "<cmd>GpImplement<cr>", { desc = "Implement selection" })
keymap.set('v', "<leader>pn", "<cmd>GpNextAgent<cr>", { desc = "Next Agent" })
keymap.set('v', "<leader>pp", "<cmd>GpChatPaste<cr>", { desc = "Visual Chat Paste" })
keymap.set('v', "<leader>pr", "<cmd>GpRewrite<cr>", { desc = "Visual Rewrite" })
keymap.set('v', "<leader>ps", "<cmd>GpStop<cr>", { desc = "GpStop" })
keymap.set('v', "<leader>pt", "<cmd>GpChatToggle<cr>", { desc = "Visual Toggle Chat" })
keymap.set('v', "<leader>pwa", "<cmd>GpWhisperAppend<cr>", { desc = "Whisper Append" })
keymap.set('v', "<leader>pwb", "<cmd>GpWhisperPrepend<cr>", { desc = "Whisper Prepend" })
keymap.set('v', "<leader>pwe", "<cmd>GpWhisperEnew<cr>", { desc = "Whisper Enew" })
keymap.set('v', "<leader>pwn", "<cmd>GpWhisperNew<cr>", { desc = "Whisper New" })
keymap.set('v', "<leader>pwp", "<cmd>GpWhisperPopup<cr>", { desc = "Whisper Popup" })
keymap.set('v', "<leader>pwr", "<cmd>GpWhisperRewrite<cr>", { desc = "Whisper Rewrite" })
keymap.set('v', "<leader>pwt", "<cmd>GpWhisperTabnew<cr>", { desc = "Whisper Tabnew" })
keymap.set('v', "<leader>pwv", "<cmd>GpWhisperVnew<cr>", { desc = "Whisper Vnew" })
keymap.set('v', "<leader>pww", "<cmd>GpWhisper<cr>", { desc = "Whisper" })
keymap.set('v', "<leader>px", "<cmd>GpContext<cr>", { desc = "Visual GpContext" })

--- Normal mode
keymap.set('n',"<leader>p<C-t>", "<cmd>GpChatNew tabnew<cr>", { desc = "New Chat tabnew" })
keymap.set('n',"<leader>p<C-v>", "<cmd>GpChatNew vsplit<cr>", { desc = "New Chat vsplit" })
keymap.set('n',"<leader>p<C-x>", "<cmd>GpChatNew split<cr>", { desc = "New Chat split" })
keymap.set('n',"<leader>pa", "<cmd>GpAppend<cr>", { desc = "Append (after)" })
keymap.set('n',"<leader>pb", "<cmd>GpPrepend<cr>", { desc = "Prepend (before)" })
keymap.set('n',"<leader>pc", "<cmd>GpChatNew<cr>", { desc = "New Chat" })
keymap.set('n',"<leader>pf", "<cmd>GpChatFinder<cr>", { desc = "Chat Finder" })
keymap.set('n',"<leader>pge", "<cmd>GpEnew<cr>", { desc = "GpEnew" })
keymap.set('n',"<leader>pgn", "<cmd>GpNew<cr>", { desc = "GpNew" })
keymap.set('n',"<leader>pgp", "<cmd>GpPopup<cr>", { desc = "Popup" })
keymap.set('n',"<leader>pgt", "<cmd>GpTabnew<cr>", { desc = "GpTabnew" })
keymap.set('n',"<leader>pgv", "<cmd>GpVnew<cr>", { desc = "GpVnew" })
keymap.set('n',"<leader>pn", "<cmd>GpNextAgent<cr>", { desc = "Next Agent" })
keymap.set('n',"<leader>pr", "<cmd>GpRewrite<cr>", { desc = "Inline Rewrite" })
keymap.set('n',"<leader>ps", "<cmd>GpStop<cr>", { desc = "GpStop" })
keymap.set('n',"<leader>pt", "<cmd>GpChatToggle<cr>", { desc = "Toggle Chat" })
keymap.set('n',"<leader>pwa", "<cmd>GpWhisperAppend<cr>", { desc = "Whisper Append (after)" })
keymap.set('n',"<leader>pwb", "<cmd>GpWhisperPrepend<cr>", { desc = "Whisper Prepend (before)" })
keymap.set('n',"<leader>pwe", "<cmd>GpWhisperEnew<cr>", { desc = "Whisper Enew" })
keymap.set('n',"<leader>pwn", "<cmd>GpWhisperNew<cr>", { desc = "Whisper New" })
keymap.set('n',"<leader>pwp", "<cmd>GpWhisperPopup<cr>", { desc = "Whisper Popup" })
keymap.set('n',"<leader>pwr", "<cmd>GpWhisperRewrite<cr>", { desc = "Whisper Inline Rewrite" })
keymap.set('n',"<leader>pwt", "<cmd>GpWhisperTabnew<cr>", { desc = "Whisper Tabnew" })
keymap.set('n',"<leader>pwv", "<cmd>GpWhisperVnew<cr>", { desc = "Whisper Vnew" })
keymap.set('n',"<leader>pww", "<cmd>GpWhisper<cr>", { desc = "Whisper" })
keymap.set('n',"<leader>px", "<cmd>GpContext<cr>", { desc = "Toggle GpContext" })

--- Insert mode
keymap.set('i',"<leader>p<C-t>", "<cmd>GpChatNew tabnew<cr>", { desc = "New Chat tabnew" })
keymap.set('i',"<leader>p<C-v>", "<cmd>GpChatNew vsplit<cr>", { desc = "New Chat vsplit" })
keymap.set('i',"<leader>p<C-x>", "<cmd>GpChatNew split<cr>", { desc = "New Chat split" })
keymap.set('i',"<leader>pa", "<cmd>GpAppend<cr>", { desc = "Append (after)" })
keymap.set('i',"<leader>pb", "<cmd>GpPrepend<cr>", { desc = "Prepend (before)" })
keymap.set('i',"<leader>pc", "<cmd>GpChatNew<cr>", { desc = "New Chat" })
keymap.set('i',"<leader>pf", "<cmd>GpChatFinder<cr>", { desc = "Chat Finder" })
keymap.set('i',"<leader>pge", "<cmd>GpEnew<cr>", { desc = "GpEnew" })
keymap.set('i',"<leader>pgn", "<cmd>GpNew<cr>", { desc = "GpNew" })
keymap.set('i',"<leader>pgp", "<cmd>GpPopup<cr>", { desc = "Popup" })
keymap.set('i',"<leader>pgt", "<cmd>GpTabnew<cr>", { desc = "GpTabnew" })
keymap.set('i',"<leader>pgv", "<cmd>GpVnew<cr>", { desc = "GpVnew" })
keymap.set('i',"<leader>pn", "<cmd>GpNextAgent<cr>", { desc = "Next Agent" })
keymap.set('i',"<leader>pr", "<cmd>GpRewrite<cr>", { desc = "Inline Rewrite" })
keymap.set('i',"<leader>ps", "<cmd>GpStop<cr>", { desc = "GpStop" })
keymap.set('i',"<leader>pt", "<cmd>GpChatToggle<cr>", { desc = "Toggle Chat" })
keymap.set('i',"<leader>pwa", "<cmd>GpWhisperAppend<cr>", { desc = "Whisper Append (after)" })
keymap.set('i',"<leader>pwb", "<cmd>GpWhisperPrepend<cr>", { desc = "Whisper Prepend (before)" })
keymap.set('i',"<leader>pwe", "<cmd>GpWhisperEnew<cr>", { desc = "Whisper Enew" })
keymap.set('i',"<leader>pwn", "<cmd>GpWhisperNew<cr>", { desc = "Whisper New" })
keymap.set('i',"<leader>pwp", "<cmd>GpWhisperPopup<cr>", { desc = "Whisper Popup" })
keymap.set('i',"<leader>pwr", "<cmd>GpWhisperRewrite<cr>", { desc = "Whisper Inline Rewrite" })
keymap.set('i',"<leader>pwt", "<cmd>GpWhisperTabnew<cr>", { desc = "Whisper Tabnew" })
keymap.set('i',"<leader>pwv", "<cmd>GpWhisperVnew<cr>", { desc = "Whisper Vnew" })
keymap.set('i',"<leader>pww", "<cmd>GpWhisper<cr>", { desc = "Whisper" })
keymap.set('i',"<leader>px", "<cmd>GpContext<cr>", { desc = "Toggle GpContext" })
