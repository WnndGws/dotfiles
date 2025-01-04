-- Some OS detectors
local is_wsl = vim.fn.has("wsl") == 1
-- local is_mac = vim.fn.has("macunix") == 1
-- local is_linux = not is_wsl and not is_mac

---------------
--- Colours ---
---------------
vim.api.nvim_set_hl(0, "Folded", { bg="NONE", underline=true })

-------------------
--- Autocommands---
-------------------
local uv = vim.loop

--- Use tmux-rename upon launching nvim ---
vim.api.nvim_create_autocmd('VimEnter', {
	callback = function()
		if vim.env.TMUX_PLUGIN_MANAGER_PATH then
			uv.spawn(vim.env.TMUX_PLUGIN_MANAGER_PATH .. '/tmux-window-name/scripts/rename_session_windows.py', {})
		end
	end,
})

--- Write md buffers as you leave them
vim.api.nvim_create_autocmd("FileType", {pattern = "markdown", command = "set awa"})
-- Use the following if your buffer is set to become hidden
vim.api.nvim_create_autocmd("BufLeave", {pattern = "*.md", command = "silent! wall"})

-- Run all commands in interactive so that I can use ZSH aliases etc
vim.api.nvim_create_autocmd("VimEnter", {pattern = "*", command = "let &shell='/bin/zsh -i'"})

----------------------------
--- Fix Clipboard in WSL ---
----------------------------
if not vim.env.SSH_TTY then
	-- only set clipboard if not in ssh, to make sure the OSC 52
	-- integration works automatically. Requires Neovim >= 0.10.0
	-- WSL Clipboard support
	if is_wsl then
		-- This is NeoVim's recommended way to solve clipboard sharing if you use WSL
		-- See: https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
		vim.g.clipboard = {
			name = "WslClipboard",
			copy = {
				["+"] = "clip.exe",
				["*"] = "clip.exe",
			},
			paste = {
				["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
				["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			},
			cache_enabled = 0,
		}
	end
end

------------------------
--- General Settings ---
------------------------
vim.g.autoformat = true -- Enable autoformat

vim.opt.foldcolumn = "2"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = require("modules.foldtext")
vim.wo.conceallevel = 2

local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.autowrite = true -- Enable auto-write
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0 -- Hide nothing
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.iskeyword = "a-z,A-Z" -- Sets word boundaries to anything not in this comma separated list, numbers must refer to ASCII Table
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.enc="utf-8"
opt.spell=false
opt.spelllang = { "en_au" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 4 -- Number of spaces tabs count for
opt.softtabstop = 4
opt.termguicolors = true -- True colour support
if not vim.g.vscode then
	opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
end
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Enable line wrap

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end

-- Fix markdown indentation settings
vim.treesitter.language.register('markdown', 'vimwiki', 'wiki')
