-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
---------------------
--- Lazy Settings ---
---------------------
local global = vim.g
local opt = vim.opt

-- This file is automatically loaded by plugins.core
global.mapleader = ","
global.maplocalleader = "\\"

-- LazyVim auto format
global.autoformat = true

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
global.snacks_animate = false

-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
global.lazyvim_picker = "auto"

-- LazyVim completion engine to use.
-- Can be one of: nvim-cmp, blink.cmp
-- Leave it to "auto" to automatically use the completion engine
-- enabled with `:LazyExtras`
global.lazyvim_cmp = "nvim-cmp"

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
global.ai_cmp = false

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
global.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Optionally setup the terminal to use
-- This sets `vim.o.shell` and does some additional configuration for:
-- * pwsh
-- * powershell
-- LazyVim.terminal.setup("zsh")

-- Set LSP servers to be ignored when used with `util.root.detectors.lsp`
-- for detecting the LSP root
global.root_lsp_ignore = { "copilot" }

-- Hide deprecation warnings
global.deprecation_warnings = false

-- Show the current document symbols location from Trouble in lualine
-- You can disable this for a buffer by setting `vim.b.trouble_lualine = false`
global.trouble_lualine = true

-- Not using npm for packages
global.loaded_perl_provider = 0
------------------------
--- General Settings ---
------------------------
opt.title = true
opt.titlestring = "nvim:%F" -- See help:statusline for expansions
opt.clipboard = "unnamedplus"
opt.autowrite = true -- Enable auto-write
opt.autoread = true -- Read file after external changes
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0 -- Hide nothing
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.iskeyword = "a-z,A-Z,48-57" -- Sets word boundaries to anything not in this comma separated list, numbers must refer to ASCII Table
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
opt.enc = "utf-8"
opt.spell = true
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
opt.textwidth = 80
opt.colorcolumn = "80"
opt.undofile = true
opt.undodir = vim.fn.expand("~/.local/share/nvim/undo")
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Enable line wrap

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end

------------------
--- File types ---
------------------
vim.filetype.add({
	extension = {
		enc = "markdown",
		jinja = "html",
		opml = "xml",
		tex = "tex",
	},
})
