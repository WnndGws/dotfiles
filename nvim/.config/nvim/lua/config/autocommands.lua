-------------------
--- Autocommands---
-------------------

local uv = vim.loop

--- Use tmux-rename upon launching nvim ---
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.env.TMUX_PLUGIN_MANAGER_PATH then
			uv.spawn(vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py", {})
		end
	end,
})

--- Write md buffers as you leave them
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown,python",
	command = "set awa",
})
-- Use the following if your buffer is set to become hidden
vim.api.nvim_create_autocmd("BufLeave", { pattern = "*.md", command = "silent! wall" })

-- Run all commands in interactive so that I can use bash
vim.api.nvim_create_autocmd("VimEnter", { pattern = "*", command = "let &shell='/bin/bash -i'" })

--- Treesitter stuff
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

--- Fix Clipboard in WSL ---
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
	if is_linux then
		vim.g.clipboard = {
			copy = {
				["+"] = "wl-copy --trim-newline",
				["*"] = "wl-copy --trim-newline",
			},
			paste = {
				["+"] = "wl-paste",
				["*"] = "wl-paste",
			},
		}
	end
end

-- Debugging function to show events when needed
-- vim.api.nvim_create_augroup("ft_debug", { clear = true })
-- for _, ev in ipairs({ "BufNewFile", "BufReadPre", "BufReadPost", "BufEnter", "BufWinEnter" }) do
-- vim.api.nvim_create_autocmd(ev, {
-- group = "ft_debug",
-- pattern = "*",
-- callback = function(args)
-- local bt = vim.bo[args.buf].buftype or ""
-- vim.schedule(function()
-- vim.notify(
-- ("%s buf=%d ft=%q bt=%q nested=%s"):format(
-- ev,
-- args.buf,
-- vim.bo[args.buf].filetype,
-- bt,
-- vim.fn.getwinvar(vim.fn.bufwinid(args.buf), "&eventignore") or "?"
-- )
-- )
-- end)
-- end,
-- })
-- end

-- Rerun "filetype detect" on "BufEnter" if no filetype
vim.api.nvim_create_augroup("ft_fallback", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
	group = "ft_fallback",
	callback = function(args)
		local b = vim.bo[args.buf]
		if b.filetype == "" and b.buftype == "" and vim.api.nvim_buf_is_loaded(args.buf) then
			vim.api.nvim_buf_call(args.buf, function()
				vim.cmd("filetype detect")
			end)
		end
	end,
})

-- Let "w" and "b" stop at line end rather than wrap
local function line_bound(motion, fallback)
	return function()
		local view = vim.fn.winsaveview()
		vim.cmd(("normal! %s"):format(motion))
		if vim.fn.line(".") ~= view.lnum then
			vim.fn.winrestview(view)
			vim.cmd(("normal! %s"):format(fallback))
		end
	end
end

vim.keymap.set({ "n", "x" }, "w", line_bound("w", "$"))
vim.keymap.set({ "n", "x" }, "b", line_bound("b", "0"))
